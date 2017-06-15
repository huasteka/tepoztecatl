class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.integer :operation_type
      t.decimal :quantity
      t.references :stock, foreign_key: true

      t.timestamps
    end
  end
end
