class StockSerializer < ActiveModel::Serializer
  attributes :quantity

  belongs_to :storage
  belongs_to :item, serializer: SimpleItemSerializer
end