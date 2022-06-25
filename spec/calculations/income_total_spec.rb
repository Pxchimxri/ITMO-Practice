require 'rails_helper'

describe IncomeTotal do
  let(:service_income) { [123.123, 15.65] }

  context "valid attributes" do
    it "returns valid total income" do
      orders = [
        Order.new(service_income: service_income[0]),
        Order.new(service_income: service_income[1])
      ]

      income_total = IncomeTotal.result_for(orders)

      expect(income_total).to eq(service_income.sum)
    end
  end
end