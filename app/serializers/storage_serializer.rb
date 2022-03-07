=begin
  @apiDefine StorageModel
  @apiSuccess {Object} data
  @apiSuccess {Number} data.id
  @apiSuccess {String} data.type
  @apiSuccess {Object} data.attributes
  @apiSuccess {String} data.attributes.code
  @apiSuccess {String} data.attributes.name
  @apiSuccess {Object[]} data.attributes.children
  @apiSuccess {Number} data.attributes.children.id
  @apiSuccess {String} data.attributes.children.code
  @apiSuccess {String} data.attributes.children.name
  @apiSuccess {Number} data.attributes.children.parent_id
=end
class StorageSerializer < ActiveModel::Serializer
  attributes :code, :name, :children
end
