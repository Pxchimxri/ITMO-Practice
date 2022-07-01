class ConnectOptions
  attr_accessor :order, :params
  def initialize(params, order)
    @params = params
    @order = order
  end

  def connect
    options = Option.all
    options.each do |element|
      if @params[element.name] == "1"
        order_option = OrderOption.new(order_id: @order.id, option_id: element.id)
        order_option.save
      end
    end
  end
end
