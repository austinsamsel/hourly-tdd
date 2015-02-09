FactoryGirl.define do
  factory :work do
    start_time "2015-02-01 17:55:28"
    end_time   "2015-02-01 18:55:28"
    title { Faker::Product.product_name }
    description { Faker::Lorem.sentence(3) }
    billed false
    client_id {rand(1..10)}

    factory :invalid_work do
      start_time nil
    end
  end

end
