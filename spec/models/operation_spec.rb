require 'rails_helper'

RSpec.describe Operation, type: :model do
  # Association tests
  it { should belong_to(:stock) }

  # Validation tests
  it { should validate_presence_of(:operation_type) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:stock) }
end
