# README

# Invoice and Payment Management

This repository contains a simplified model of an invoicing system, where invoices can be partially paid using various methods (cash, check, or charge). Payments are stored in pennies, and all interactions with the system are made in dollars and cents.

## Prerequisites
The setup steps expect following tools installed on the system.

* Node version `16.20.2` or check in the **package.json** file
* Ruby version `3.1.6`
* Yarn version `1.22.22`
* Bundler

## Setup steps
  - Clone application from github.
  - Run the following commands in terminal

  ```bash
  $ bundle install
  $ yarn install
  $ rails s
  ```

## Testing
 Run the following command on the terminal to execute test suit.
  `bash
  $ rspec test/
  $ rspec test test/path_to_file # for single file

## Models

### Invoice Model

An invoice represents a request for payment with the following attributes:
- `invoice_total` (in pennies): The total amount of the invoice.
- `payments`: A collection of associated payments.

Key Methods:
- `fully_paid?`: Returns `true` if the invoice has been paid in full.
- `amount_owed`: Returns the remaining balance owed on the invoice in dollars.
- `record_payment(amount_paid, payment_method)`: Records a payment against the invoice.

### Payment Model

A payment represents a payment made on an invoice with the following attributes:
- `amount` (in pennies): The amount paid.
- `payment_method_id`: The ID of the payment method used (cash, check, or charge).

Key Methods:
- `payment_method`: Returns the payment method as a symbol (cash, check, or charge).
- `valid_payment_method?`: Returns `true` if the provided payment method is valid.

## Key Improvements

1. **Fix `fully_paid?` Method:**
   - The original logic in the `fully_paid?` method was incorrect. It now returns `true` when the `amount_owed` is zero, meaning the invoice is fully paid. The previous version was returning the opposite result due to the condition being reversed.

2. **Refine `amount_owed`:**
   - The `amount_owed` method now properly computes the remaining balance owed by subtracting the total amount paid (in pennies) from the `invoice_total` (in pennies). The calculation is then divided by 100 to return the amount in dollars. This ensures the correct value is displayed in dollars and cents.

3. **Simplify `record_payment` Method:**
   - The method now uses the `create` method directly for creating the payment, which simplifies the code and ensures the correct values are passed. The amount is properly converted to pennies (cents) before being saved to the database.

4. **Improve Error Handling for `set_payment_method_id`:**
   - In the `Payment` model, the `set_payment_method_id` method has been enhanced to handle potential issues if the `raw_payment_method` is not a valid symbol. A check is now in place to ensure that only valid payment methods (from the `METHODS` hash) are assigned to the `payment_method_id`.

5. **Fix Translation of `invoice_total` to Cents:**
   - The `translate_invoice_total_to_cents` method now correctly sets the `invoice_total` in pennies (cents) before saving it to the database. Previously, the method was modifying `invoice_total` in place but was not correctly updating the value for database storage.

6. **Refactor Payment Validation:**
   - Instead of manually checking if the `raw_payment_method` is valid, Rails validations are now used in the `Payment` model to ensure the presence of valid `payment_method_id` values. This results in better validation and error handling when creating a payment.

7. **Add Meaningful Error Messages:**
   - The validations now include more meaningful and specific error messages for both `payment_method_id` and `amount` fields. This improves clarity during debugging and provides more helpful feedback when errors occur.
