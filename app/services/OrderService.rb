class OrderService
  INTEREST_RATE = 0.05
  attr_accessor :order

  def initialize(order)
    @order = order
  end

  def assemble(client)
    order.interest_rate = INTEREST_RATE
    order.status = 'looking_for_driver'
    order.price = if order.standard?
                    rand(150..449)
                  elsif order.comfort?
                    rand(450..999)
                  else
                    rand(1000..2999)
                  end
    order.client_id = client.id
  end

  def destroy
    msg = get_message
    get_message.destroy unless msg.nil?
    order.order_options.delete_all
    order.destroy
  end

  def get_options
    order_options = []
    order_options_models = OrderOption.all
    order_options = order_options_models.select { |model| model.order_id == order.id } if order_options_models.present?
    order_options.map(&:option)
  end

  def get_message
    order.message
  end

  def cancel_order
    client = User.find(order.client_id)
    client.update(cur_order_id: nil)
    order.update(status: 'canceled')
  end

  def get_info
    string = "To: " + order.to + "<br>From: " + order.from + "<br>Price: " + order.price.to_s + "<br>Tariff: " + order.tariff + "<br>" + "Options:<br>"
    options = get_options
    options.each do |element|
      string += (element.name + ",<br>")
    end
    msg = get_message
    string += ("Message: <br>" + msg.content + "<br>") unless msg.nil?
    string += ("Client: " + order.client.name + "<br>")
    if order.driver_id.present?
      driver = User.find(order.driver_id)
      string += ("Driver: " + driver.name)
      string += (", " + driver.rating.to_s) if driver.rating.present?
    end
    string
  end

  def save
    order.save
  end
end
