class FinanceService
  def pay_off(driver, order)
    balance = driver.balance + (1 - order.interest_rate) * order.price
    driver.update(balance: balance)
  end
end
