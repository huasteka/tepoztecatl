FactoryGirl.define do
  factory :measure_unit do
    name { Faker::Lorem.word }
    sequence(:acronym) { |n| Faker::Lorem.characters(2) + n.to_s }
  end
end