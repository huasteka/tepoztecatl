=begin
  @apiDefine StockModel
  @apiSuccess {Object} data
  @apiSuccess {Number} data.id
  @apiSuccess {String} data.type
  @apiSuccess {Object} data.attributes
  @apiSuccess {String} data.attributes.quantity
  @apiSuccess {String} data.attributes.minimum_quantity
  @apiSuccess {Object} data.relationships.storage
  @apiSuccess {Object} data.relationships.storage.data
  @apiSuccess {Number} data.relationships.storage.data.id
  @apiSuccess {String} data.relationships.storage.data.type
  @apiSuccess {Object} data.relationships.item
  @apiSuccess {Object} data.relationships.item.data
  @apiSuccess {Number} data.relationships.item.data.id
  @apiSuccess {String} data.relationships.item.data.type
=end
class StockSerializer < ActiveModel::Serializer
  attributes :quantity, :minimum_quantity

  belongs_to :storage
  belongs_to :item, serializer: SimpleItemSerializer
end