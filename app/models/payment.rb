class Payment < ApplicationRecord
  METHODS = { cash: 1, check: 2, charge: 3 }

  before_validation :set_payment_method_id

  belongs_to :invoice

  attr_accessor :raw_payment_method

  validates :payment_method_id, inclusion: { in: METHODS.values }
  validates :amount, :payment_method_id, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # Returns the symbol of the payment method based on the payment_method_id value
  def payment_method
    METHODS.key(payment_method_id)
  end

  # Sets the payment_method_id based on the raw_payment_method symbol
  def set_payment_method_id
    if METHODS.keys.include?(raw_payment_method.to_sym)
      self.payment_method_id = METHODS[raw_payment_method.to_sym]
    else
      errors.add(:raw_payment_method, "is invalid")
      throw(:abort)
    end
  end
end
