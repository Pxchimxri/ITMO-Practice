class OrderStatusPresenter
  def initialize(status)
    @status = status
  end

  def bootstrap_class
    case @status
    when :looking_for_car
      "text-secondary fw-bolder"
    when :on_way, :accepted
      "text-primary fw-bolder"
    when :finished
      "text-success fw-bolder"
    when :canceled
      "text-danger fw-bolder"
    else
      bad_status
    end
  end

  def to_s
    case @status
    when :looking_for_car
      "Ищу машину"
    when :accepted
      "Заказ принят"
    when :on_way
      "В пути"
    when :finished
      "Завершен"
    when :canceled
      "Отменен"
    else
      bad_status
    end
  end

  private

  def bad_status
    raise "Status " + @status + " is not supported"
  end
end