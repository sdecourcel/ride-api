class PaymentService
  attr_reader :ride

  def initialize(attributes)
    @ride = attributes[:ride]
  end

  def bill
    return false unless @ride && @ride.created?
    @ride
  end

  def pay
    return false unless @ride && @ride.started?
    @ride
  end

  def reimburse
    return false unless @ride && @ride.completed?
    @ride
  end
end
