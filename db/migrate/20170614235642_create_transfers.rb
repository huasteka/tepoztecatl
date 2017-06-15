class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :withdraw_operation, foreign_key: { to_table: :operations }
      t.references :deposit_operation, foreign_key: { to_table: :operations }

      t.timestamps
    end
  end
end
