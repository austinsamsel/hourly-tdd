require 'rails_helper'

RSpec.describe ClientsController, :type => :controller do
  describe "anonymous user" do
    before :each do
      # This simulates an anonymous user
      login_with nil
    end

    it "should be redirected to signin" do
      get :index
      expect( response ).to redirect_to( new_user_session_path )
    end

    it "should let a user see all the clients" do
      login_with create( :user )
      get :index
      #expect( response ).to render_template( :index )
      response.should be_success
    end
  end
  
  describe "GET #index" do
    before(:each) do
      @current_user = :user
      login_with (@current_user)
      client =  Client.new( :name => 'one', :user_id => 1)
      client2 = Client.new(:name=> 'two', :user_id=> 2)
    end
    # it "lists only current_user's clients" do
    #   FactoryGirl.create(:client)
    #   @client = FactoryGirl.create(:client)
    #   @client2 = FactoryGirl.create(:client)            
    #   @current_user.clients << @client
    #   get "index"
    # end
  end
end