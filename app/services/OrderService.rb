class OrderService
  attr_accessor :order
  def initialize(order)
    @order = order
  end

  def assemble(client)
    order.interest_rate = 0.05
    order.status = "not_finished"
    if order.standard?
      order.price = rand(300)+150
    elsif order.comfort?
      order.price = rand(550)+450
    else
      order.price = rand(2000)+1000
    end
    order.client_id = client.id
    order.driver_id = User.where(:role => "admin").first.id
  end

  def destroy
    get_message.destroy
    order.order_options.delete_all
    order.destroy
  end

  def get_options
    order_options = []
    order_options_models = OrderOption.all
    if order_options_models.present?
      order_options = order_options_models.select { |model| model.order_id == order.id }
    end
    order_options.map(&:option)
  end

  def get_message
    Message.where(:order_id => order.id).first
  end

  def get_info
    string = "To: " + order.to + "\n" +
      "From: " + order.from + "\n" +
      "Price: " + order.price.to_s + "\n" +
      "Tariff: " + order.tariff + "\n" +
      "Options: \n"
    options = get_options
    options.each do |element|
      string += (element.name + ",\n")
    end
    msg = get_message
    if msg != nil
      string += ("Message: \n" + msg.content)
    end
    string
  end

  def save
    order.save
  end
end