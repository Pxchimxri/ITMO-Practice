class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @create_user = CreateUser.new(@user)
    @create_user.create
    if @create_user.save
      redirect_to :action => 'index'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @create_user = CreateUser.new(@user)
    @string = @create_user.get_order
    @link = @create_user.get_link_name
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
    @user.destroy

    redirect_to :action => 'index'
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