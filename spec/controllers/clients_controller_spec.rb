require 'rails_helper'

describe ClientsController do
  describe 'GET #index' do
    context 'user logs in to index' do
      it "populates an array of user's clients" do
        login_with create( :user )
        smith = create(:client, user_id: 1)
        jones = create(:client, user_id: 2)
        get :index
        expect(assigns(:clients)).to match_array([smith])
      end
      it "renders the :index template" do
        login_with create( :user )
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested client to @client" do
      client = create(:client)
      get :show, id: client
      expect(assigns(:client)).to eq client
    end
    it "renders the :show template" do
      login_with create( :user )
      client = create(:client)
      get :show, id: client
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new Client to @client" do
      login_with create(:user)
      get :new
      expect(assigns(:client)).to be_a_new(Client)
    end
    it "renders the :new template" do
      login_with create(:user)
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested client to @client" do
      client = create(:client)
      get :edit, id: client
      expect(assigns(:client)).to eq client
    end
    it "renders the :edit template" do
      login_with create(:user)
      client = create(:client)
      get :edit, id: client
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new client in the database" do
        login_with create(:user)
        expect{
          post :create, client: attributes_for(:client)
        }.to change(Client, :count).by(1)
      end
      it "redirects to clients#show" do
        login_with create(:user)
        post :create, client: attributes_for(:client)
        expect(response).to redirect_to client_path(assigns[:client])
      end
    end
    context "with invalid attributes" do
      it "does not save the new client in the database" do
        login_with create(:user)
        expect{
          post :create,
          client: attributes_for(:invalid_client)
        }.not_to change(Client, :count)
      end
      it "re-renders the :new template" do
        login_with create(:user)
        post :create,
          client: attributes_for(:invalid_client)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @client = create(:client,
        name: 'Bro and Bro, Inc.')
      login_with create(:user)
    end
    context "with valid attributes" do
      it "locates the requested @client" do
        patch :update, id: @client, client: attributes_for(:client)
        expect(assigns(:client)).to eq(@client)
      end
      it "changes @client's attributes" do
        patch :update, id: @client,
          client: attributes_for(:client,
            name: 'The Bros, Inc.')
        @client.reload
        expect(@client.name).to eq('The Bros, Inc.')
      end
      it "redirects to the updated client" do
        patch :update, id: @client, client: attributes_for(:client)
        expect(response).to redirect_to @client
      end
    end
    context "with invalid attributes" do
      it "does not change the client's attributes" do
        patch :update, id: @client,
          client: attributes_for(:client,
            name: nil)
        @client.reload
        expect(@client.name).not_to eq(nil)
      end
      it "re-renders the :edit template" do
        patch :update, id: @client,
          client: attributes_for(:invalid_client)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @client = create(:client)
      login_with create(:user)
    end
    it "deletes the client" do
      expect{
        delete :destroy, id: @client
      }.to change(Client, :count).by(-1)
    end
    it "redirects to users#index" do
      delete :destroy, id: @client
      expect(response).to redirect_to clients_url
    end
  end



# previous stuff....

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