namespace :db do
  task populate: :environment do

    Client.destroy_all

    20.times do
      Client.create(
        name: Faker::Company.name,
        )
    end

  end
end