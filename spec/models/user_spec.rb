require 'rails_helper'

describe User do

  # shoulda gem
  #it { should belong_to(:user) }
  it { should have_many(:clients).dependent(:destroy) }



end
