FactoryBot.define do
  factory :stock do
    quantity { Faker::Number.decimal(8, 2) }
    minimum_quantity { Faker::Number.decimal(8, 2) }

    association :storage, factory: :storage
    association :item, factory: :item
  end
end
