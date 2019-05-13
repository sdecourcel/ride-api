require 'rails_helper'

RSpec.describe PaymentService do

  context 'with invalid attributes' do
    it 'returns false' do
      service = described_class.new(ride: nil)
      expect(service.bill).to be false
    end

    it 'does not update ride status' do
      ride = create(:ride)
      service = described_class.new(ride: nil)
      ride_last_update = ride.updated_at
      service.bill
      expect(ride.updated_at).to eq(ride_last_update)
    end
  end




end
