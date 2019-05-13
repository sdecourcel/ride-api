require 'rails_helper'

RSpec.describe Ride, type: :model do
  context 'is valid' do
    it 'with a status and a unique token of 4 alphanumeric characters'  do
      ride = create(:ride)
      expect(ride).to be_valid
    end

    it 'with a token length equal to 4' do
      ride = create(:ride)
      expect(ride.token.length).to eq(4)
    end

    it 'with a status equal to created' do
      ride = create(:ride)
      expect(ride.created?).to be true
    end
  end

  context 'is invalid' do
    it 'without a token' do
      ride = create(:ride)
      ride.token = nil
      ride.valid?
      expect(ride.errors[:token]).to include("can't be blank")
    end

    it 'without a status' do
      ride = create(:ride)
      ride.status = nil
      ride.valid?
      expect(ride.errors[:status]).to include("can't be blank")
    end

    it 'with a token length different from 4' do
      ride = create(:ride)
      ride.token = "aaa11"
      ride.valid?
      expect(ride.errors[:token]).to include("is invalid")
      # expect(ride.errors[:token]).to include("is the wrong length (should be 4 characters)")
    end

    it 'with a token containing dashes' do
      ride = create(:ride)
      ride.token = "a-1_"
      ride.valid?
      expect(ride.errors[:token]).to include("is invalid")
    end

    it 'with a token not unique' do
      r1 = create(:ride)
      r2 = create(:ride)
      r2.token = r1.token
      r2.valid?
      expect(r2.errors[:token]).to include("has already been taken")
    end
  end
end
