class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    p order_params.keys
    @order = Order.new(order_params)
    p @order
    @create_order = CreateOrder.new(order_params.to_h)
    @create_order.create
    if @create_order.save
      redirect_to :action => 'index'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
    @driver = User.find(@order.driver_id)
    @client = User.find(@order.client_id)
  end

  def edit
    @order = Order.find(params[:id])
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
    params.require(:order).permit(:from, :to, :tariff)
  end

end
