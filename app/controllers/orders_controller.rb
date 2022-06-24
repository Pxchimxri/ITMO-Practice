class OrdersController < ApplicationController
  def index
    @orders = Order.all
    role = "adm1in" # TODO: replace hardcoded role with cancancan
    if role == "client"
      ClientOrderListService.call(@orders)
    elsif role == "driver"
      DriverOrderListService.call(@orders)
    elsif role == "admin"
      @income_total = AdminOrderListService.call(@orders).result
    else
      invalid_role(role)
    end
    render "order/index_#{role}"
  end

  private

  def order_params
    params.require(:order).permit!
  end

  def invalid_role(role, msg = "Order index request was made with invalid role parameter #{role}", exception = ActionController::BadRequest)
    Rails.logger.error(msg)
    raise exception.new, msg
  end
end