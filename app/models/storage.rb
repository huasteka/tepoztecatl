class Storage < ApplicationRecord
  has_many :children, class_name: 'Storage', foreign_key: :parent_id, autosave: true
  belongs_to :parent, class_name: 'Storage', optional: true

  validates_presence_of :name, :code
  validates_uniqueness_of :code
end
