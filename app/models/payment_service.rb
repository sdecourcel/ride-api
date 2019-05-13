class PaymentService
  attr_reader :ride

  def initialize(attributes)
    @ride = attributes[:ride]
  end

  def bill
    return false unless @ride
    @ride.started!
  end

  def pay
    return false unless @ride
    @ride.completed!
  end

  def reimburse
    return false unless @ride
    @ride.cancelled!
  end
end
