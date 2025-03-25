FactoryBot.define do
  factory :payment do
    amount { 5000 }  # Setting the amount in pennies (50.00 dollars)
    association :invoice
    raw_payment_method { 'cash' }
  end
end
