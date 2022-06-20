class OrderService
  INTEREST_RATE = 0.05
  attr_accessor :order
  def initialize(order)
    @order = order
  end

  def assemble(client)
    order.interest_rate = INTEREST_RATE
    order.status = "not_finished"
    if order.standard?
      order.price = rand(300)+150
    elsif order.comfort?
      order.price = rand(550)+450
    else
      order.price = rand(2000)+1000
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
    if order_options_models.present?
      order_options = order_options_models.select { |model| model.order_id == order.id }
    end
    order_options.map(&:option)
  end

  def get_message
    order.message
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
    string += ("Message: \n" + msg.content) unless msg.nil?
    string
  end

  def save
    p order
    order.save
  end
end