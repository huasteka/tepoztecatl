class Stock < ApplicationRecord
  belongs_to :storage
  belongs_to :item
  has_many :operations

  validates_presence_of :storage, :item
  validates_numericality_of :quantity, greater_than_or_equal_to: 0.00
  validates_numericality_of :minimum_quantity, allow_nil: true

  def self.find_or_create_stock(storage_id, item_id)
    self.where(storage_id: storage_id, item_id: item_id).first_or_create!
  end
end
