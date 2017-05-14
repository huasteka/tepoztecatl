class Item < ApplicationRecord
  belongs_to :input_measure_unit, :class_name => 'MeasureUnit'
  belongs_to :output_measure_unit, :class_name => 'MeasureUnit'

  validates_presence_of :code, :input_quantity, :output_quantity, :input_measure_unit, :output_measure_unit
  validates_uniqueness_of :code
end
