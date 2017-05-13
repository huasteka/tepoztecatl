FactoryGirl.define do
  factory :storage do
    code { Faker::Number.number(10) }
    name { Faker::Lorem.word }
  end
end