class PaymentService
  attr_reader :ride

  def initialize(attributes)
    @ride = attributes[:ride]
  end

  def bill
    return false unless @ride&.created?

    @ride
  end

  def pay
    return false unless @ride&.started?

    @ride
  end

  def reimburse
    return false unless @ride&.completed?

    @ride
  end
end
