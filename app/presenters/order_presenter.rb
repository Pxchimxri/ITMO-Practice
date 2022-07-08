class OrderPresenter
  def initialize(order)
    @order = order
  end

  def start_datetime
    @order.created_at.strftime('%d %b, %H:%M')
  end

  def start_finish_datetime
    if (@order.created_at - @order.updated_at).to_i < 1
      @order.created_at.strftime('%d %b, %H:%M') + @order.updated_at.strftime(' - %H:%M')
    else
      @order.created_at.strftime('%d %b, %H:%M') + @order.updated_at.strftime(' - %d %b, %H:%M')
    end
  end

  def status_formatting
    if @order.finished?
      { icon: "icofont icofont-check-circled", text_type: "text-success" }
    elsif @order.looking_for_car?
      { icon: "icofont icofont-clock-time", text_type: "text-secondary" }
    elsif @order.accepted?
      { icon: "icofont icofont-circled-left", text_type: "text-primary" }
    elsif @order.on_way?
      { icon: "icofont icofont-circled-right", text_type: "text-primary" }
    else
      { icon: "icofont icofont-close-circled", text_type: "text-danger" }
    end
  end

  def driver_name
    if @order.driver
      @order.driver.name
    end
  end
end