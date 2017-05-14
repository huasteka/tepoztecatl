require 'rails_helper'

RSpec.describe MeasureUnit, type: :model do
  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:acronym) }

  it { should validate_uniqueness_of(:acronym) }
end
