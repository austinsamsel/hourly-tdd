FactoryGirl.define do
  factory :client do
    name { Faker::Company.name }
    user_id {rand(1..10)}
    
    factory :invalid_client do
      name " "
    end
  end
end