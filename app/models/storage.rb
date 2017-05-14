class Storage < ApplicationRecord
  has_many :children, class_name: 'Storage', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Storage', optional: true

  validates_presence_of :code, :name
  validates_uniqueness_of :code
end
