=begin
  @apiDefine MeasureUnitModel
  @apiSuccess {Object} data
  @apiSuccess {Number} data.id
  @apiSuccess {String} data.type
  @apiSuccess {Object} data.attributes
  @apiSuccess {String} data.attributes.name
  @apiSuccess {String} data.attributes.acronym
=end
class MeasureUnitSerializer < ActiveModel::Serializer
  attributes :name, :acronym
end