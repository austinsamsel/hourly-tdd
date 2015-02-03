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
    it "lists user's clients" do
      #current_user.clients.should be_true 
      #current_user.clients.should be_true
      login_with create( :user )
      get :index
      response.should be_success
    end
  end

end