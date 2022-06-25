class CreateMessage
  attr_accessor :message
  def initialize(msg, order)
    @message = Message.new(content: msg, order_id: order.id)
  end

  def save
    @message.save
  end
end
