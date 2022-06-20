class ClientService
  attr_accessor :client
  def initialize(client)
    @client = client
  end

  def cancel_order
    order = Order.find(client.cur_order_id)
    order.update(status: "canceled")
    client.update(cur_order_id: nil)
  end

end

