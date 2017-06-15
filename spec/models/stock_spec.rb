require 'rails_helper'

RSpec.describe Stock, type: :model do
  # Association tests
  it { should belong_to(:storage) }
  it { should belong_to(:item) }

  # Validation tests
  it { should validate_presence_of(:storage) }
  it { should validate_presence_of(:item) }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0.00) }
end
