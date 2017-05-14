require 'rails_helper'

RSpec.describe Stock, type: :model do
  # Association tests
  it { should belong_to(:storage) }
  it { should belong_to(:item) }

  # Validation tests
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:storage) }
  it { should validate_presence_of(:item) }
end
