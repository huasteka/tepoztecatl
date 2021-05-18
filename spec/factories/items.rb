FactoryBot.define do
  factory :item do
    sequence(:code) { |n| n }
    input_quantity { Faker::Number.decimal(8, 2) }
    output_quantity { Faker::Number.decimal(8, 2) }

    association :input_measure_unit, factory: :measure_unit
    association :output_measure_unit, factory: :measure_unit
  end
end
