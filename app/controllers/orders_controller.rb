class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, except: %i[new create index past]
  before_action :load_user
  authorize_resource

  has_scope :by_status, type: :array

  def new
    @order = Order.new
    @options = Option.all
    @msg = params[:msg] || ''
  end

  def create
    @order = Order.new(from: order_params[:from], to: order_params[:to], tariff: order_params[:tariff])
    order_service = OrderService.new(@order)
    order_service.assemble(@user)
    user_service = UserService.new(@user)
    if order_service.save
      user_service.new_order(order_service.order)
      CreateMessage.new(order_params[:message], order_service.order).save if order_params[:message].present?
      ConnectOptions.new(order_params, @order).connect
    else
      redirect_to new_order_path(user_id: @user.id, msg: 'Incorrect input')
    end
  end

  def show
    @client = User.find(@order.client_id)
    @driver = User.find(@order.driver_id) if @order.driver_id.present?
    @info = OrderService.new(@order).get_info
    @first_point = @order.from
    @second_point = @order.to
  end

  def edit
    @order = Order.find(params[:id])
    @options = Option.all
    @msg = params[:msg] || ''
  end

  def update
    if order_params[:driver_rating].present?
      @order.update(order_params)
      redirect_to rate_order_path(@order)
    elsif @order.update(from: order_params[:from], to: order_params[:to], tariff: order_params[:tariff])
      @user = User.find(params[:client_id])
      CreateMessage.new(order_params[:message], @order).save if order_params[:message].present?
      ConnectOptions.new(order_params, @order).connect
      redirect_to user_path(@user)
    else
      redirect_to edit_order_path(user_id: @user.id, msg: 'Incorrect input')
    end
  end

  def destroy
    @order = Order.find(params[:id])
    order_service = OrderService.new(@order)
    order_service.destroy
    redirect_to action: 'index'
  end

  def index
    if current_user.role == 'driver'
      @orders = Order.looking_for_car
    else
      @orders = Order.all # TODO: implement pagination
      @income_total = IncomeCalculator.call(@orders).result
      render 'orders/index_admin'
    end
  end

  def past
    @orders = apply_scopes(Order).accessible_by(current_ability, :show)
  end

  def cancel
    if @user.driver?
      DriverService.new(@user).cancel_order
      redirect_to order_path(@order)
    else
      OrderService.new(@order).cancel_order
      redirect_to user_path(@user)
    end
  end

  def accept
    @driver = @user
    DriverService.new(@driver).accept(@order)
    redirect_to order_path(@order)
  end

  def close
    @driver = User.find(@order.driver_id)
    DriverService.new(@driver).close
    redirect_to user_path(@driver)
  end

  def load_user
    @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
  rescue ActiveRecord::RecordNotFound
    render body: 'Not found', status: 404
  end

  def load_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render body: 'Not found', status: 404
  rescue CanCan::AccessDenied
    render body: 'Not allowed', status: 403
  end

  def rate_page
    @client = User.find(@order.client_id)
    @driver = User.find(@order.driver_id)
    @rating_presence = @order.driver_rating.present?
  end

  def rate
    RateService.new.rate_driver(@order)
    redirect_to rate_page_order_path(@order)
  end

  def skip_rate
    @client = User.find(@order.client_id)
    RateService.new.close_cur_order_id(@order)
    redirect_to user_path(@client)
  end

  private

  def order_params
    options = Option.all
    option_names = options.map(&:name)
    params.require(:order).permit(:from, :to, :tariff, :message, option_names, :driver_rating)
  end
end
