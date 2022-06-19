class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    user_service = UserService.new(@user)
    user_service.assemble
    if user_service.save
      redirect_to :action => 'index'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    user_service = UserService.new(@user)
    @string = user_service.get_order
    if @user.cur_order_id.present?
      @order = Order.find(@user.cur_order_id)
      @driver = User.find(@order.driver_id)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    Order.where(:client_id => @user.id).all.each do |order|
      OrderService.new(order).destroy
    end
    Order.where(:driver_id => @user.id).all.each do |order|
      OrderService.new(order).destroy
    end
    @user.destroy

    redirect_to :action => 'index'
  end

  def close
    @driver = User.find(params[:id])
    DriverService.new(@driver).close
    redirect_to user_path(@driver)
  end

  def cancel
    @user = User.find(params[:id])
    ClientService.new(@user).cancel_order
    redirect_to user_path(@user)
  end

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @users }
      format.json { render json: @users }
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :role)
    end
end
