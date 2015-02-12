FactoryGirl.define do
  factory :client do
    name { Faker::Company.name }
    user_id 1
    
    factory :invalid_client do
      name " "
    end
  end
end