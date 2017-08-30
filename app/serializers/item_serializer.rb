class ItemSerializer < ActiveModel::Serializer
  attributes :code, :name, :input_quantity, :output_quantity

  belongs_to :input_measure_unit
  belongs_to :output_measure_unit
end