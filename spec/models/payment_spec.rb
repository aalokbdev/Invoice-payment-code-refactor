require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe '#payment_method' do
    it 'returns the correct payment method symbol' do
      payment = create(:payment, payment_method_id: 1)
      expect(payment.payment_method).to eq(:cash)
    end
  end

  describe '#set_payment_method_id' do
    it 'sets the payment_method_id from raw_payment_method' do
      payment = build(:payment, raw_payment_method: :check)
      payment.set_payment_method_id
      expect(payment.payment_method_id).to eq(2)
    end

    it 'does not set an invalid payment_method_id' do
      payment = build(:payment, raw_payment_method: :invalid_method)
      expect { payment.set_payment_method_id }.to throw_symbol(:abort)
    end
  end
end
