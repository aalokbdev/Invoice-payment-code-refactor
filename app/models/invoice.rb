class Invoice < ApplicationRecord
  before_save :translate_invoice_total_to_cents

  has_many :payments, dependent: :destroy

  validates :invoice_total, presence: true, numericality: { greater_than: 0 }

  # Returns true if the invoice is fully paid
  def fully_paid?
    amount_owed.zero?
  end

  # Returns the remaining amount owed for the invoice in dollars
  def amount_owed
    (invoice_total - payments.sum(:amount)*100) / 100.0
  end

  # Accepts a payment amount (in dollars) and payment method and records the payment
  def record_payment(amount_paid, payment_method)
    payments.create!(amount: (amount_paid * 100).to_i, raw_payment_method: payment_method)
  end

  private

  # Converts the invoice total from dollars to cents before saving
  def translate_invoice_total_to_cents
    self.invoice_total = (invoice_total * 100).to_i
  end
end
