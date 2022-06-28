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
    string = 'To: ' + order.to + "\n" +
             'From: ' + order.from + "\n" +
             'Price: ' + order.price.to_s + "\n" +
             'Tariff: ' + order.tariff + "\n" +
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
    order.save
  end
end
