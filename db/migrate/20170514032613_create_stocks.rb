class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.decimal :quantity, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :minimum_quantity, :precision => 12, :scale => 2
      t.references :storage, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
