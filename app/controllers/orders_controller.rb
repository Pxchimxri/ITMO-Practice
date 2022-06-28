class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, except: %i[index new create]
  before_action :load_user
  authorize_resource

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
      redirect_to user_path(@user)
    else
      redirect_to new_order_path(user_id: @user.id, msg: 'Incorrect input')
    end
  end

  def show
    # @order = Order.find(params[:id])
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

    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order = Order.find(params[:id])
    order_service = OrderService.new(@order)
    order_service.destroy
    redirect_to action: 'index'
  end

  def index
    @orders = Order.accessible_by(current_ability)

    @orders_to_take = @orders.select { |order| order.status == 'looking_for_driver' }

    @orders = @orders.reject { |order| order.status == 'looking_for_driver' }

    @current_order = Order.find(@user.cur_order_id) if @user.cur_order_id.present?

    user_service = UserService.new(@user)
    @current_order_info = user_service.get_order

    if params[:user_id].present?
      @orders = @orders.select do |order|
        order.client_id.to_s == params[:user_id] || order.driver_id.to_s == params[:user_id] || order.status == 'looking_for_driver'
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def cancel
    OrderService.new(@order).cancel_order
    redirect_to user_path(@user)
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

  private

  def order_params
    options = Option.all
    option_names = options.map(&:name)
    params.require(:order).permit(:from, :to, :tariff, :message, option_names)
  end
end
