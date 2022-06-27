class OrdersController < ApplicationController
  def new
    @order = Order.new
    @options = Option.all
    @msg = params[:msg] || ''
  end

  def create
    @user = User.find(params[:client_id])
    @order = Order.new(from: order_params[:from], to: order_params[:to], tariff: order_params[:tariff])
    order_service = OrderService.new(@order)
    order_service.assemble(@user)
    user_service = UserService.new(@user)
    if order_service.save
      user_service.new_order(order_service.order)
      if order_params[:message].present?
        CreateMessage.new(order_params[:message], order_service.order).save
      end
      ConnectOptions.new(order_params, @order).connect
      redirect_to user_path(@user)
    else
      redirect_to new_order_path(user_id: @user.id, msg: "Incorrect input")
    end
  end

  def show
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])
    @client = User.find(@order.client_id)
    @driver = User.find(@order.driver_id) if @order.driver_id.present?
    @info = OrderService.new(@order).get_info
  end

  def edit
    @order = Order.find(params[:id])
    @options = Option.all
    @msg = params[:msg] || ''
  end

  def update
    @order = Order.find(params[:id])
    if order_params[:driver_rating].present?
      @order.update(order_params)
      redirect_to rate_order_path(@order)
    else
      if @order.update(from: order_params[:from], to: order_params[:to], tariff: order_params[:tariff])
        @user = User.find(params[:client_id])
        if order_params[:message].present?
          CreateMessage.new(order_params[:message], @order).save
        end
        ConnectOptions.new(order_params, @order).connect
        redirect_to user_path(@user)
      else
        redirect_to edit_order_path(user_id: @user.id, msg: "Incorrect input")
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    order_service = OrderService.new(@order)
    order_service.destroy
    redirect_to :action => 'index'
  end

  def index
    user = User.find(params[:user_id])
    @role = user.role                                                         #
    if @role == "client"                                                     # TODO: replace hardcoded role with cancancan
      @orders = Order.client(user)                                           #
      ClientOrderListService.call(@orders)
    elsif @role == "driver"
      @orders = Order.looking_for_car_and_user_active
      DriverOrderListService.call(@orders)
    elsif @role == "admin"
      @orders = Order.all                                                   # TODO: implement pagination
      @income_total = AdminOrderListService.call(@orders).result
      render "orders/index_admin"
    else
      invalid_role(@role)
    end
  end

  def cancel
    @order = Order.find(params[:id])
    @driver = User.find(params[:user_id])
    DriverService.new(@driver).cancel_order
    redirect_to order_path(@order, user_id: params[:user_id])
  end

  def accept
    @order = Order.find(params[:id])
    @driver = User.find(params[:user_id])
    DriverService.new(@driver).accept(@order)
    redirect_to order_path(@order, user_id: params[:user_id])
  end

  def rate_page
    @order = Order.find(params[:id])
    @client, @driver = User.find(@order.client_id), User.find(@order.driver_id)
    @rating_presence = @order.driver_rating.present?
  end

  def rate
    @order = Order.find(params[:id])
    RateService.new.rate_driver(@order)
    redirect_to rate_page_order_path(@order)
  end

  def skip_rate
    @order = Order.find(params[:id])
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

  def invalid_role(role, msg = "Order index request was made with invalid role parameter #{role}", exception = ActionController::BadRequest)
    Rails.logger.warn(msg)
    raise exception.new, msg
  end
end
