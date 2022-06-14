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
    @create_order = CreateOrder.new(@order)
    @create_order.create(@user)
    @create_user = CreateUser.new(@user)
    p @order
    if @create_order.save
      @create_user.new_order(@create_order.order)
      @create_message = CreateMessage.new(order_params[:message], @create_order.order)
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
    @info = CreateOrder.new(@order).get_info
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
    @create_order = CreateOrder.new(@order)
    @create_order.get_message.destroy
    OrderOption.where(:order_id => @order.id ).each do |option|
      option.destroy
    end
    @order.destroy


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
