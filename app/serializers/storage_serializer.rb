class StorageSerializer < ActiveModel::Serializer
  attributes :code, :name, :children
end
