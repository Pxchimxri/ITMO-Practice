class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  private

  def order_params
    params.require(:order).permit!
  end
end