require 'rails_helper'

describe Client do

  it "is valid with a name and user id" do
     expect(build(:client)).to be_valid
  end
  it "is invalid without a name" do
    client = build(:client, name: ' ')
    client.valid?
    expect(client.errors[:name]).to include("can't be blank")
  end
  it "is invalid without a user reference" do
    client = build(:client, :user_id => nil)
    client.valid?
    expect(client.errors[:user_id]).to include("can't be blank")
  end

# need to get this to work still
  # it "returns the most recent clients" do
  #   first = Client.new(
  #       :created_at => "Thu, 20 Aug 2009 17:56:21 UTC +00:00" 
  #     )
  #   second = Client.new(
  #       :created_at => "Thu, 20 Aug 2008 17:56:21 UTC +00:00" 
  #     )
  #   #expect(Client.all).to eq [first, second]
  #   # expect(Client.all.to_sql).to eq Client.order('').to_sql
  #   #expect(Client.order('created_at desc')).to eq [first, second]
  #   expect(Client.all).to eq [first, second]
  # end


  it { should belong_to(:user) }


end
