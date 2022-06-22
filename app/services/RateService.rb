class RateService

  def rate_driver(order)
    driver = User.find(order.driver_id)
    orders = Order.where(driver_id: driver.id)
    count = 0
    rating = 0.0
    orders.each do |ord|
      if ord.driver_rating.present?
        count += 1
        rating += ord.driver_rating
      end
    end
    rating /= count
    driver.update(rating: rating) if count != 0
    close_cur_order_id(order)
  end

  def close_cur_order_id(order)
    client = User.find(order.client_id)
    client.update(cur_order_id: nil)
  end

end

