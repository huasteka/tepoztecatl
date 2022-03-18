=begin
  @apiDefine OperationModel
  @apiSuccess {Object} data
  @apiSuccess {Number} data.id
  @apiSuccess {String} data.type
  @apiSuccess {String} data.attributes.operation_type
  @apiSuccess {Number} data.attributes.quantity
  @apiSuccess {Date} data.attributes.created_at
  @apiSuccess {Object} data.attributes.stock
  @apiSuccess {Number} data.attributes.stock.minimum_quantity
  @apiSuccess {Object} data.attributes.stock.storage
  @apiSuccess {Number} data.attributes.stock.storage.id
  @apiSuccess {String} data.attributes.stock.storage.name
  @apiSuccess {String} data.attributes.stock.storage.code
  @apiSuccess {Object} data.attributes.stock.item
  @apiSuccess {Number} data.attributes.stock.item.id
  @apiSuccess {String} data.attributes.stock.item.name
  @apiSuccess {String} data.attributes.stock.item.code
=end
class OperationSerializer < ActiveModel::Serializer
  attributes :operation_type, :quantity, :created_at

  attribute :stock do
    {
        minimum_quantity: object.stock.minimum_quantity,
        storage: {
            id: object.stock.storage.id,
            name: object.stock.storage.name,
            code: object.stock.storage.code,
        },
        item: {
            id: object.stock.item.id,
            name: object.stock.item.name,
            code: object.stock.item.code,
        }
    }
  end
end
