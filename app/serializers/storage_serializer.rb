class StorageSerializer < ActiveModel::Serializer
  attributes :code, :name, :children

  private

  def children
    customized_children = []
    object.children.each do |child|
      customized_children.push(child.attributes)
    end
  end

end
