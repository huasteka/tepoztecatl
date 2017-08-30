class ItemWithStocksSerializer < ActiveModel::Serializer
  attributes :code, :name

  belongs_to :input_measure_unit
  belongs_to :output_measure_unit

  has_many :stocks
end