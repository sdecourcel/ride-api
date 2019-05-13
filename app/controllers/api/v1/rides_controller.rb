class Api::V1::RidesController < Api::V1::BaseController
  before_action :set_ride, except: :create

  def create
    @ride = Ride.new
    if @ride.save
      display_status
      render json: @ride.as_json
    else
      render_error
    end
  end

  def bill_and_update_status_to_started
    if @ride.generate_bill
      display_status
      render json: @ride.as_json
    else
      render_error
    end
  end

  def pay_and_update_status_to_completed
    if @ride.proceed_payment
      display_status
      render json: @ride.as_json
    else
      render_error
    end
  end

  def reimburse_and_update_status_to_cancelled
    if @ride.proceed_reimburse
      display_status
      render json: @ride.as_json
    else
      render_error
    end
  end

  private

  def set_ride
    @ride = Ride.find_by_token(params[:token])
  end

  def display_status
    puts "Trajet #{@ride.token} : #{@ride.explicit_status}"
  end

  def render_error
    error_messages = @ride.errors.messages
    puts "Trajet #{@ride.token} :"
    error_messages.each do |message|
      puts message
    end
    render json: { errors: error_messages }, status: :unprocessable_entity
  end
end
