require 'rails_helper'

RSpec.describe Item, type: :model do
  # Association tests
  it { should belong_to(:input_measure_unit) }
  it { should belong_to(:output_measure_unit) }

  # Validation tests
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:input_quantity) }
  it { should validate_presence_of(:output_quantity) }
  it { should validate_presence_of(:input_measure_unit) }
  it { should validate_presence_of(:output_measure_unit) }

  it { should validate_uniqueness_of(:code) }
end
