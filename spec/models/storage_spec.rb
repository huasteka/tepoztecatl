require 'rails_helper'

RSpec.describe Storage, type: :model do
  # Association tests
  it { should have_many(:children) }
  it { should belong_to(:parent) }

  # Validation tests
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:code) }
end
