class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user
  authorize_resource

  def show
    user_service = UserService.new(@user)
    @info = user_service.get_order
    @money = FinanceService.new.count_money if @user.admin?
    if @user.cur_order_id.present?
      @order = Order.find(@user.cur_order_id)
    end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Order.where(client_id: @user.id).all.each do |order|
      OrderService.new(order).destroy
    end
    Order.where(driver_id: @user.id).all.each do |order|
      OrderService.new(order).destroy
    end
    @user.destroy

    redirect_to action: 'index'
  end

  def pick_up_passenger
    DriverService.new(@user).pick_up_passenger
    redirect_to user_path(@user)
  end

  def index
    @users = User.accessible_by(current_ability)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @users }
      format.json { render json: @users }
    end
  end

  def load_user
    @user = params[:id].present? ? User.find(params[:id]) : current_user
  rescue ActiveRecord::RecordNotFound
    render body: 'Not found', status: 404
  end
end
