class MeasureUnit < ApplicationRecord
  validates_presence_of :name, :acronym
  validates_uniqueness_of :acronym
end
