class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :code
      t.string :name
      t.references :input_measure_unit, foreign_key: { to_table: :measure_units }
      t.decimal :input_quantity
      t.references :output_measure_unit, foreign_key: { to_table: :measure_units }
      t.decimal :output_quantity

      t.timestamps
    end
  end
end
