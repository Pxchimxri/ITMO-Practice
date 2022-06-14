class CreateUser
  attr_accessor :user


  def initialize(user)
    @user = user
  end

  def get_link_name
    if @user.driver?
      "Look for orders"
    elsif @user.client?
      "New order"
    end
  end



  def get_order
    if @user.cur_order_id != nil
      order = Order.find(@user.cur_order_id)
      create_order = CreateOrder.new(order)
      ("Заказ:\n" + create_order.get_info)
    else
      "Нет заказа"
    end

  end

  def create
    @user.active = true
  end

  def new_order(order)
    @user.update(cur_order_id: order.id)
  end

  def save
    @user.save
  end


end
