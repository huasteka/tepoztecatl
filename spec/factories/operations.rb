FactoryBot.define do
  factory :operation do
    quantity { Faker::Number.decimal(8, 2) }
    association :stock, factory: :stock
  end
end
