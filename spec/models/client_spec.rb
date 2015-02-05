require 'rails_helper'

# RSpec.describe Client, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"

    # it { should validate_presence_of :user_id }
    # it { should belong_to(:user) }

describe Client do
  before :each do
    @client = Client.new(
      :name => "The Company", 
      user_id: '1'
    )
  end
  it "is valid with a name." do
     expect(@client).to be_valid
  end
  it "is invalid without a name" do
    client = Client.new(
      :name => " "
    )
    client.valid?
    expect(client.errors[:name]).to include("can't be blank")
  end
  it "is valid with a user reference" do
     expect(@client).to be_valid
  end
  it "is invalid without a user reference" do
    client = Client.new(:user_id => nil)
    client.valid?
    expect(client.errors[:name]).to include("can't be blank")
  end


  it { should belong_to(:user) }



end
