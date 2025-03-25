# spec/models/invoice_spec.rb

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:invoice_total) }
    it { should validate_numericality_of(:invoice_total).is_greater_than(0) }
  end

  describe '#fully_paid?' do
    it 'returns true when the invoice is fully paid' do
      invoice = create(:invoice, invoice_total: 10000)
      create(:payment, invoice: invoice, amount: 10000, payment_method_id: 1)
      expect(invoice.fully_paid?).to be(true)
    end

    it 'returns false when the invoice is not fully paid' do
      invoice = create(:invoice, invoice_total: 10000)
      create(:payment, invoice: invoice, amount: 5000, payment_method_id: 1)
      expect(invoice.fully_paid?).to be(false)
    end
  end

  describe '#amount_owed' do
    it 'returns the correct amount owed in dollars' do
      invoice = create(:invoice, invoice_total: 10000)
      create(:payment, invoice: invoice, amount: 5000, payment_method_id: 1)
      expect(invoice.amount_owed).to eq(5000.0)
    end
  end

  describe '#record_payment' do
    it 'creates a payment and records the payment amount in pennies' do
      invoice = create(:invoice, invoice_total: 10000)
      invoice.record_payment(25.50, :charge)
      expect(invoice.payments.count).to eq(1)
      expect(invoice.payments.first.amount).to eq(2550)
    end
  end
end
