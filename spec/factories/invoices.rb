FactoryBot.define do
  factory :invoice do
    invoice_total { 10000 }  # Setting the invoice total in pennies (100.00 dollars)
  end
end
