class CreateBats < ActiveRecord::Migration
  def change
    create_table :bats do |t|
      t.string :name
      t.text :description
      t.money :price
      t.string :sku

      t.timestamps null: false
    end
  end
end
