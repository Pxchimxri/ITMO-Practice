class IncomeCalculator < ApplicationService
  def call
    OrdersWithIncome.result_for(@orders)
    IncomeTotal.result_for(@orders)
  end

  private

  def initialize(orders)
    @orders = orders
  end
end