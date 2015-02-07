FactoryGirl.define do
  factory :client do
    name { Faker::Company.name }
    user_id {rand(1..10)}
  end
end