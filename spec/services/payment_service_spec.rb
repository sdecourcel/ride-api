require 'rails_helper'

RSpec.describe PaymentService do

  describe '#bill' do
    context 'with valid attributes' do
      it 'returns ride' do
        ride = create(:ride)
        service = described_class.new(ride: ride)
        expect(service.bill).to eq(ride)
      end
    end

    context 'with invalid attributes' do
      it 'returns false without attributes' do
        service = described_class.new(ride: nil)
        expect(service.bill).to be false
      end

      it 'returns false with started status' do
        ride = create(:ride, :with_started_status)
        service = described_class.new(ride: ride)
        expect(service.bill).to be false
      end
      it 'returns false with completed status' do
        ride = create(:ride, :with_completed_status)
        service = described_class.new(ride: ride)
        expect(service.bill).to be false
      end
      it 'returns false with cancelled status' do
        ride = create(:ride, :with_cancelled_status)
        service = described_class.new(ride: ride)
        expect(service.bill).to be false
      end
    end
  end

  describe '#pay' do
    context 'with valid attributes' do
      it 'returns ride' do
        ride = create(:ride, :with_started_status)
        service = described_class.new(ride: ride)
        expect(service.pay).to eq(ride)
      end
    end

    context 'with invalid attributes' do
      it 'returns false without attributes' do
        service = described_class.new(ride: nil)
        expect(service.pay).to be false
      end

      it 'returns false with created status' do
        ride = create(:ride)
        service = described_class.new(ride: ride)
        expect(service.pay).to be false
      end
      it 'returns false with completed status' do
        ride = create(:ride, :with_completed_status)
        service = described_class.new(ride: ride)
        expect(service.pay).to be false
      end
      it 'returns false with cancelled status' do
        ride = create(:ride, :with_cancelled_status)
        service = described_class.new(ride: ride)
        expect(service.pay).to be false
      end
    end
  end

  describe '#reimburse' do
    context 'with valid attributes' do
      it 'returns ride' do
        ride = create(:ride, :with_completed_status)
        service = described_class.new(ride: ride)
        expect(service.reimburse).to eq(ride)
      end
    end

    context 'with invalid attributes' do
      it 'returns false without attributes' do
        service = described_class.new(ride: nil)
        expect(service.reimburse).to be false
      end

      it 'returns false with started status' do
        ride = create(:ride, :with_started_status)
        service = described_class.new(ride: ride)
        expect(service.reimburse).to be false
      end
      it 'returns false with created status' do
        ride = create(:ride)
        service = described_class.new(ride: ride)
        expect(service.reimburse).to be false
      end
      it 'returns false with cancelled status' do
        ride = create(:ride, :with_cancelled_status)
        service = described_class.new(ride: ride)
        expect(service.reimburse).to be false
      end
    end
  end








end
