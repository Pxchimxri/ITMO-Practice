class OrdersController < ApplicationController
  def new
    @order = Order.new
    @options = Option.all
  end

  def create
    @options = Option.all
    @user = User.find(params[:client_id])
    @order = Order.new(from: order_params[:from], to: order_params[:to], tariff: order_params[:tariff])
    p @order
    order_service = OrderService.new(@order)
    order_service.create(@user)
    user_service = UserService.new(@user)
    p @order
    if order_service.save
      user_service.new_order(order_service.order)
      @create_message = CreateMessage.new(order_params[:message], order_service.order)
      @create_message.save
      ConnectOptions.new(order_params, @order).connect
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
    @client = User.find(@order.client_id)
    @driver = User.find(@order.driver_id)
    @info = OrderService.new(@order).get_info
  end

  def edit
    @order = Order.find(params[:id])
    @options = Option.all
    @option_names = []
    @options.each do |element|
      @option_names.push(element.name)
    end
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


    redirect_to :action => 'index'
  end

  def index
    @orders = Order.all
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @orders }
      format.json { render json: @orders }
    end
  end
  private
  def order_params
    options = Option.all
    option_names = []
    options.each do |element|
      option_names.push(element.name)
    end
    params.require(:order).permit(:from, :to, :tariff, :message, option_names)
  end


end
