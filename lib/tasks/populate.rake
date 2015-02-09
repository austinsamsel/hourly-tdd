namespace :db do
  task populate: :environment do

    Client.destroy_all
    Work.destroy_all

    def random
      r = Random.new
      r.rand(1...50)
    end

    def time
        Time.at(0.0 + rand * (Time.now.to_f - 0.0.to_f)).to_date
    end

    20.times do
      Client.create(
        name: Faker::Company.name,
        user_id: random
        )
    end

     100.times do
      Work.create(
        start_time: time,
        end_time: time,
        title: Faker::Product.product_name,
        description: Faker::Lorem.sentence(3),
        billed: false,
        client_id: random
        )
     end
        

    # Work.destroy_all

    # def random_status
    #   [true, false].sample
    # end

    # 20.times do
    #   Work.create(
    #     start_time: Faker::
    #     end_time: Faker::
    #     title: Faker::
    #     description: Faker::
    #     billed: Faker::

    #     first_name: Faker::Name.first_name,
    #     last_name: Faker::Name.last_name,
    #     email: Faker::Internet.email,
    #     phone: Faker::PhoneNumber.phone_number,
    #     status: random_status,
    #     notes: Faker::HipsterIpsum.words(10).join(' ')
    #     )
    # end

  end
end