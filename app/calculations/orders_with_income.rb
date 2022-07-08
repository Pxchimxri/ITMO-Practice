class OrdersWithIncome < ApplicationCalculation
  set_cache_expiry_every 1.day

  private

  def result
    subject.each do |order|
      order.service_income = order.price * order.interest_rate
      order.driver_income = order.price - order.service_income
    end
  end
end