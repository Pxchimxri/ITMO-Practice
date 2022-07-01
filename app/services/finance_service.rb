class FinanceService
  def pay_off(driver, order)
    balance = driver.balance + (1 - order.interest_rate) * order.price
    driver.update(balance: balance)
  end

  def count_money
    money = 0.0
    Order.find_in_batches do |orders|
      orders.each do |order|
        money += order.interest_rate * order.price
      end
    end
    money
  end
end
