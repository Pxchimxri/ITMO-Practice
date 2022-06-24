require 'rails_helper'

describe IncomeTotal do
  let(:service_income) { [123.123, 15.65] }

  it "returns valid total income with valid attrs" do
    orders = [
      Order.new(service_income: service_income[0]),
      Order.new(service_income: service_income[1])
    ]

    income_total = IncomeTotal.result_for(orders)

    expect(income_total).to eq(service_income.sum)
  end
end