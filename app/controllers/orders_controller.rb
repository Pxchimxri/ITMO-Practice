class OrdersController < ApplicationController
  def index
    role = "client"                                                         #
    if role == "client"                                                     # TODO: replace hardcoded role with cancancan
      @orders = ClientOrdersHistoryQuery.call(client: User.client.first)    #
      ClientOrderListService.call(@orders)
    elsif role == "driver"
      @orders = LookingForCarOrdersQuery.call
      DriverOrderListService.call(@orders)
    elsif role == "admin"
      @orders = Order.all                                               # TODO: implement pagination
      @income_total = AdminOrderListService.call(@orders).result
    else
      invalid_role(role)
    end
    render "orders/index_#{role}"
  end

  private

  def order_params
    params.require(:order).permit!
  end

  def invalid_role(role, msg = "Order index request was made with invalid role parameter #{role}", exception = ActionController::BadRequest)
    Rails.logger.warn(msg)
    raise exception.new, msg
  end
end