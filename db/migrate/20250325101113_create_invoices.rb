class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.integer :invoice_total

      t.timestamps
    end
  end
end
