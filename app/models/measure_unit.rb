class MeasureUnit < ApplicationRecord
  validates_presence_of :name, :acronym
end
