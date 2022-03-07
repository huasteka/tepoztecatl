=begin
  @apiDefine SimpleItemModel
  @apiSuccess {Object} data
  @apiSuccess {Number} data.id
  @apiSuccess {String} data.type
  @apiSuccess {Object} data.attributes
  @apiSuccess {String} data.attributes.code
  @apiSuccess {String} data.attributes.name
=end
class SimpleItemSerializer < ActiveModel::Serializer
  attributes :code, :name
end