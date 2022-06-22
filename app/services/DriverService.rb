class DriverService
  attr_accessor :driver
  def initialize(driver)
    @driver = driver
  end

  def accept(order)
    driver.update(cur_order_id: order.id)
    order.update(driver_id: driver.id)
  end

  def cancel_order
    order = Order.find(driver.cur_order_id)
    driver.update(cur_order_id: nil)
    order.update(driver_id: nil)
  end

  def close
    order = Order.find(driver.cur_order_id)
    order.update(status: "finished")
    FinanceService.new.pay_off(driver, order)
    driver.update(cur_order_id: nil)
  end
end
