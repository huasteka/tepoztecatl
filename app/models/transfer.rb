class Transfer < ApplicationRecord
  belongs_to :withdraw_operation, :class_name => 'Operation'
  belongs_to :deposit_operation, :class_name => 'Operation'

  validates_presence_of :withdraw_operation, :deposit_operation
end
