namespace :db do
  task populate: :environment do

    Client.destroy_all

    def random_user
      r = Random.new
      r.rand(1...20)
    end

    20.times do
      Client.create(
        name: Faker::Company.name,
        user_id: random_user
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