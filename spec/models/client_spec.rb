require 'rails_helper'

# RSpec.describe Client, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"

    # it { should validate_presence_of :user_id }
    # it { should belong_to(:user) }

describe Client do
  it "is valid with a name." do
     Client.new(:name => " ").should_not be_valid
  end
  it "is invalid without a user reference" do
    Client.new(:user_id => nil).should_not be_valid
  end
  

  it { should belong_to(:user) }



end
