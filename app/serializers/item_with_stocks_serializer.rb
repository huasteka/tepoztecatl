=begin
  @apiDefine ItemWithStockModel
  @apiSuccess {Object} data
  @apiSuccess {Number} data.id
  @apiSuccess {String} data.type
  @apiSuccess {Object} data.attributes
  @apiSuccess {String} data.attributes.code
  @apiSuccess {String} data.attributes.name
  @apiSuccess {String} data.attributes.input_quantity
  @apiSuccess {String} data.attributes.output_quantity
  @apiSuccess {Object} data.relationships.input_measure_unit
  @apiSuccess {Object} data.relationships.input_measure_unit.data
  @apiSuccess {Number} data.relationships.input_measure_unit.data.id
  @apiSuccess {String} data.relationships.input_measure_unit.data.type
  @apiSuccess {Object} data.relationships.output_measure_unit
  @apiSuccess {Object} data.relationships.output_measure_unit.data
  @apiSuccess {Number} data.relationships.output_measure_unit.data.id
  @apiSuccess {String} data.relationships.output_measure_unit.data.type
  @apiSuccess {Object} data.stocks
  @apiSuccess {Object[]} data.stocks.data
  @apiSuccess {Number} data.stocks.data.id
  @apiSuccess {String} data.stocks.data.type
=end
class ItemWithStocksSerializer < ActiveModel::Serializer
  attributes :code, :name, :input_quantity, :output_quantity

  belongs_to :input_measure_unit
  belongs_to :output_measure_unit

  has_many :stocks
end