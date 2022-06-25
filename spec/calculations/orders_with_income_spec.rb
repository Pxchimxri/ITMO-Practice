require 'rails_helper'

describe OrdersWithIncome do
  let(:price) { 123.123 }
  let(:interest_rate) { 0.069 }

  context "valid attributes" do
    it "returns order with valid service and driver income" do
      order = Order.new(price: price, interest_rate: interest_rate)

      OrdersWithIncome.result_for([order])

      expect(order.service_income.round(6)).to eq(8.495487)
      expect(order.driver_income.round(6)).to eq(114.627513)
    end
  end
end
