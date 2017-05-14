class Stock < ApplicationRecord
  belongs_to :storage
  belongs_to :item

  validates_presence_of :quantity, :storage, :item
end
