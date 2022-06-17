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
    driver_id = User.where(:role => "admin").first.id
    order.update(driver_id: driver_id)
  end

  def close
    order = Order.find(driver.cur_order_id)
    order.update(status: "finished")
    finance_service = FinanceService.new(order)
    finance_service.pay_off
    driver.update(cur_order_id: nil)
    user = User.find(order.client_id)
    user.update(cur_order_id: nil)
  end
end
