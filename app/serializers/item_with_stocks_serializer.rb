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
  @apiSuccess {Object} data.attributes.input_measure_unit
  @apiSuccess {Number} data.attributes.input_measure_unit.id
  @apiSuccess {String} data.attributes.input_measure_unit.name
  @apiSuccess {String} data.attributes.input_measure_unit.acronym
  @apiSuccess {Object} data.attributes.output_measure_unit
  @apiSuccess {Number} data.attributes.output_measure_unit.id
  @apiSuccess {String} data.attributes.output_measure_unit.name
  @apiSuccess {String} data.attributes.output_measure_unit.acronym
  @apiSuccess {Object} data.relationships
  @apiSuccess {Object} data.relationships.stocks
  @apiSuccess {Object[]} data.relationships.stocks.data
  @apiSuccess {Number} data.relationships.stocks.data.id
  @apiSuccess {String} data.relationships.stocks.data.type
=end
class ItemWithStocksSerializer < ActiveModel::Serializer
  attributes :code, :name, :input_quantity, :output_quantity

  attribute :input_measure_unit do
    {
        id: object.input_measure_unit.id,
        name: object.input_measure_unit.name,
        acronym: object.input_measure_unit.acronym,
    }
  end

  attribute :output_measure_unit do
    {
        id: object.output_measure_unit.id,
        name: object.output_measure_unit.name,
        acronym: object.output_measure_unit.acronym,
    }
  end

  has_many :stocks
end