class OrdersPresenter
  attr_reader :drivers_income
  attr_reader :service_fee

  def initialize(orders)
    @orders = orders
    @drivers_income = Array.new(orders.length)
    @service_fee = Array.new(orders.length)
    calc_service_money
  end

  def start_datetime(i)
    @orders[i].created_at.strftime('%d %b, %H:%M')
  end

  def start_finish_datetime(i)
    if (@orders[i].created_at - @orders[i].updated_at).to_i < 1
      @orders[i].created_at.strftime('%d %b, %H:%M') + @orders[i].updated_at.strftime(' - %H:%M')
    else
      @orders[i].created_at.strftime('%d %b, %H:%M') + @orders[i].updated_at.strftime(' - %d %b, %H:%M')
    end
  end

  def status_formatting(i)
    if @orders[i].finished?
      { icon: "icofont icofont-check-circled", text_type: "text-success" }
    elsif @orders[i].on_way?
      { icon: "", text_type: "text-secondary" }
    else
      { icon: "icofont icofont-close-circled", text_type: "text-danger" }
    end
  end

  def fee_total
    service_fee_total = 0
    @orders.each_with_index do |_, i|
      service_fee_total += @service_fee[i]
    end
    service_fee_total
  end

  private

  def calc_service_money
    @orders.each_with_index do |order, i|
      @drivers_income[i] = (order.price / (1 + order.interest_rate)).round(2)
      service_fee[i] = @drivers_income[i] * order.interest_rate
    end
  end
end