class UserService
  attr_accessor :user


  def initialize(user)
    @user = user
  end

  def get_order
    if user.cur_order_id.present?
      order = Order.find(user.cur_order_id)
      order_service = OrderService.new(order)
      ("Заказ:\n" + order_service.get_info)
    else
      "Нет заказа"
    end

  end

  def assemble
    user.active = true
    if user.driver?
      user.balance = 0
    end
  end

  def new_order(order)
    user.update(cur_order_id: order.id)
  end

  def save
    user.save
  end


end
