class CreateOrder
  attr_accessor :order
  def initialize(params)
    @order = Order.new(from: params[:from], to: params[:to], tariff: params[:tariff])
  end
  def create
    @order.interest_rate = 0.05
    @order.status = "not_finished"
    if @order.standard?
      @order.price = rand(300)+150
    elsif @order.comfort?
      @order.price = rand(550)+450
    else
      @order.price = rand(2000)+1000
    end
    @order.client_id = 17
    @order.driver_id = 16
  end

  def save
    @order.save
  end
end