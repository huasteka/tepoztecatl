FactoryGirl.define do
  factory :measure_unit do
    name { Faker::Lorem.word }
    acronym { Faker::Lorem.characters(3) }
  end
end