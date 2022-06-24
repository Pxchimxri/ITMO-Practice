class DriverOrderListService < ApplicationService
  def call
  end

  private

  def initialize(orders)
    @orders = orders
  end
end