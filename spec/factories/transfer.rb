FactoryGirl.define do
  factory :transfer do
    association :withdraw_operation, factory: :operation
    association :deposit_operation, factory: :operation
  end
end
