class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :sku
      t.string :description
      t.integer :ordered
      t.integer :shipped
      t.string :unit_price
      t.date :date

      t.timestamps null: false
    end
  end
end
