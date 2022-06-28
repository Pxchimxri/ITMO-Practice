class UserService
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def orders
    return Order.find(driver_id: @user.id, status: 'looking_for_driver') if @user.driver?
    return Order.find(client_id: @user.id) if @user.client?
    return Order.all if @user.admin?
  end

  def get_order
    if @user.cur_order_id.present?
      order = Order.find(@user.cur_order_id)
      order_service = OrderService.new(order)
      order_service.get_info
    end
  end

  def assemble
    user.active = true
    user.balance = 0 if user.driver?
  end

  def new_order(order)
    user.update(cur_order_id: order.id)
  end

  def save
    user.save
  end
end
