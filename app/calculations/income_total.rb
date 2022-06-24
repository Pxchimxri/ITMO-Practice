class IncomeTotal < ApplicationCalculation
  set_cache_expiry_every 1.day

  private

  def result
    service_income_total = 0
    subject.each do |order|
      service_income_total += order.service_income
    end
    service_income_total
  end
end
