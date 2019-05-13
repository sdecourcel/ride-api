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

  describe '#generate_bill' do
    context 'with created status' do
      it 'updates ride status to started' do
        ride = create(:ride)
        ride.generate_bill
        expect(ride.started?).to be true
      end
    end

    context 'returns false' do
      it 'with started status' do
        ride = create(:ride, :with_started_status)
        expect(ride.generate_bill).to be false
      end
      it 'with completed status' do
        ride = create(:ride, :with_completed_status)
        expect(ride.generate_bill).to be false
      end
      it 'with cancelled status' do
        ride = create(:ride, :with_cancelled_status)
        expect(ride.generate_bill).to be false
      end
    end
  end

  describe '#proceed_payment' do
    context 'with started status' do
      it 'updates ride status to completed' do
        ride = create(:ride, :with_started_status)
        ride.proceed_payment
        expect(ride.completed?).to be true
      end
    end

    context 'returns false' do
      it 'with created status' do
        ride = create(:ride)
        expect(ride.proceed_payment).to be false
      end
      it 'with completed status' do
        ride = create(:ride, :with_completed_status)
        expect(ride.proceed_payment).to be false
      end
      it 'with cancelled status' do
        ride = create(:ride, :with_cancelled_status)
        expect(ride.proceed_payment).to be false
      end
    end
  end

  describe '#proceed_reimburse' do
    context 'with completed status' do
      it 'updates ride status to cancelled' do
        ride = create(:ride, :with_completed_status)
        ride.proceed_reimburse
        expect(ride.cancelled?).to be true
      end
    end

    context 'returns false' do
      it 'with created status' do
        ride = create(:ride)
        expect(ride.proceed_reimburse).to be false
      end
      it 'with started status' do
        ride = create(:ride, :with_started_status)
        expect(ride.proceed_reimburse).to be false
      end
      it 'with cancelled status' do
        ride = create(:ride, :with_cancelled_status)
        expect(ride.proceed_reimburse).to be false
      end
    end
  end
end
