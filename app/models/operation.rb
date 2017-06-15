class Operation < ApplicationRecord
  belongs_to :stock
  enum operation_type: [:deposit, :withdraw]

  validates_presence_of :operation_type, :quantity, :stock
end