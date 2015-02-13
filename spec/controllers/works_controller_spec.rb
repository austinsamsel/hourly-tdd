require 'rails_helper'

describe WorksController do
  before :each do
    @client = create(:client) 
    @work = create(:work, client: @client) 
  end

  describe 'GET #index' do
    context 'user logs in to index' do
      # it "populates an array of user's works by client" do
      #   login_with create( :user )
      #   smith = create(:work, client_id: 1)
      #   jones = create(:work, client_id: 2)
      #   get :index
      #   expect(assigns(:works)).to match_array([smith])
      # end
      it "renders the :index template" do
        login_with create( :user )
        get :index, client_id: @client.id
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested work to @work" do
      work = create(:work)
      get :show, id: work, client_id: @client
      expect(assigns(:work)).to eq work
    end
    it "renders the :show template" do
      login_with create( :user )
      work = create(:work)
      get :show, id: work, client_id: @client
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new work to @work" do
      login_with create(:user)
      get :new, client_id: @client
      expect(assigns(:work)).to be_a_new(Work)
    end
    it "renders the :new template" do
      login_with create(:user)
      get :new, client_id: @client
      expect(response).to render_template :new
    end
    it "only shows current user's services"
  end

  describe 'GET #edit' do
    it "assigns the requested work to @work" do
      login_with create(:user)
      #work = create(:work)
      get :edit, { client_id: @client.id, id: @work }
      expect(assigns(:work)).to eq @work
    end
    it "renders the :edit template" do
      login_with create(:user)
      get :edit, { client_id: @client.id, id: @work }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
    before :each do
      @work_attributes = attributes_for(:work, client_id: @client)
      @work_invalid = attributes_for(:invalid_work, client_id: @client)
    end
      it "saves the new work in the database" do
        login_with create(:user)
        expect{
          post :create, client_id: @client, work: @work_attributes
        }.to change(Work, :count).by(1)
      end
  ######
    it "assigns the requested work to @work" do
      work = create(:work)
      get :show, id: work, client_id: @client
      expect(assigns(:work)).to eq work
    end
    it "renders the :show template" do
      login_with create( :user )
      work = create(:work)
      get :show, id: work, client_id: @client
      expect(response).to render_template :show
    end
  #####
      it "redirects to works#show" do
        login_with create(:user)
        @client_id = @client.id
        work = attributes_for(:work)
        post :create, 
          work: attributes_for(:work), client_id: @client
        #expect(response).to redirect_to(assigns(:work))
        expect(response).to redirect_to(client_work_path(@work, @client_id))
      end
    end
    context "with invalid attributes" do
      it "does not save the new work in the database" do
        login_with create(:user)
        expect{
          post :create,
          work: attributes_for(:invalid_work), client_id: @client
        }.not_to change(Work, :count)
      end
      it "re-renders the :new template" do
        login_with create(:user)
        post :create,
          work: attributes_for(:invalid_work), client_id: @client
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @work = create(:work,
        title: 'Bro and Bro, Inc.',
        client: @client)
      login_with create(:user)
    end
    context "with valid attributes" do
      it "locates the requested @work" do
        patch :update, id: @work, client_id: @client, 
          work: attributes_for(:work, client_id: @client)
        expect(assigns(:work)).to eq(@work)
      end
      it "changes @work's attributes" do
        patch :update, client_id: @client, id: @work, 
          work: attributes_for(:work,
            title: 'The Bros, Inc.'), client_id: @client
        @work.reload
        expect(@work.title).to eq('The Bros, Inc.')
      end
      it "redirects to the updated work" do
        patch :update, client_id: @client, id: @work, work: attributes_for(:work)
        expect(response).to redirect_to [@work.client, @work]
      end
    end
    context "with invalid attributes" do
      it "does not change the work's attributes" do
        patch :update, client_id: @client, id: @work,
          work: attributes_for(:work,
            title: nil)
        @work.reload
        expect(@work.title).not_to eq(nil)
      end
      it "re-renders the :edit template" do
        patch :update, id: @work, client_id: @client, 
          work: attributes_for(:invalid_work), client_id: @client
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      login_with create(:user)
    end
    it "deletes the work" do
      expect{
        delete :destroy, { client_id: @client.id, id: @work }
      }.to change(Work, :count).by(-1)
    end
    it "redirects to users#index" do
      delete :destroy, { client_id: @client.id, id: @work }
      expect(response).to redirect_to client_works_url
    end
  end

### alternate user.  
  
  describe "restrict alternate user" do
    before :each do
      @client = create(:client) 
      @work = create(:work, client: @client) 
      @users_work = create(:work)
      login_with create( :alt )
    end

    describe 'GET #index' do
      context 'user logs in to index' do
        # it "populates an array of user's works by client" do
        #   login_with create( :user )
        #   smith = create(:work, client_id: 1)
        #   jones = create(:work, client_id: 2)
        #   get :index
        #   expect(assigns(:works)).to match_array([smith])
        # end
        it "redirects when... renders the :index template" do
          get :index, client_id: @client.id
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'GET #show' do
      it "redirects when... renders the :show template" do
        work = create(:work)
        get :show, id: work, client_id: @client
        expect(response).to redirect_to root_url
      end
    end

    describe 'GET #new' do
      it "does not… assign a new work to @work" do
        get :new, client_id: @client
        expect(assigns(:work)).not_to be_a_new(Work)
      end
      it "redirects when... renders the :new template" do
        get :new, client_id: @client
        expect(response).to redirect_to root_url
      end
      it "only shows current user's services"
    end

    describe 'GET #edit' do
      it "redirects when... renders the :edit template" do
        get :edit, { client_id: @client.id, id: @work }
        expect(response).to redirect_to root_url
      end
    end

    describe 'POST #create' do
      context "with valid attributes" do
        before :each do
          @work_attributes = attributes_for(:work, client_id: @client)
          @work_invalid = attributes_for(:invalid_work, client_id: @client)
        end
        it "does not... save the new work in the database" do
          expect{
            post :create, client_id: @client, work: @work_attributes
          }.to change(Work, :count).by(0)
        end
        it "does not... renders the :show template" do
          work = create(:work)
          get :show, id: work, client_id: @client
          expect(response).to redirect_to root_url
        end
        it "does not... redirects to works#show" do
          @client_id = @client.id
          work = attributes_for(:work)
          post :create, 
            work: attributes_for(:work), client_id: @client
          #expect(response).to redirect_to(assigns(:work))
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'PATCH #update' do
      before :each do
        @work = create(:work,
          title: 'Bro and Bro, Inc.',
          client: @client)
      end
      context "with valid attributes" do
        it "does not... change @work's attributes" do
          patch :update, client_id: @client, id: @work, 
            work: attributes_for(:work,
              title: 'The Bros, Inc.'), client_id: @client
          @work.reload
          expect(@work.title).to eq('Bro and Bro, Inc.')
        end
        it "does not... redirect to the updated work" do
          patch :update, client_id: @client, id: @work, work: attributes_for(:work)
          expect(response).to redirect_to root_url
        end
      end
      context "with invalid attributes" do
        it "does not... change the work's attributes" do
          patch :update, client_id: @client, id: @work,
            work: attributes_for(:work,
              title: nil)
          @work.reload
          expect(@work.title).not_to eq(nil)
        end
        it "does not... re-render the :edit template" do
          patch :update, id: @work, client_id: @client, 
            work: attributes_for(:invalid_work), client_id: @client
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'DELETE #destroy' do
      before :each do
      end
      it "does not... delete the work" do
        expect{
          delete :destroy, { client_id: @client.id, id: @work }
        }.to change(Work, :count).by(0)
      end
      it "does not... redirect to users#index" do
        delete :destroy, { client_id: @client.id, id: @work }
        expect(response).to redirect_to root_url
      end
    end
  end
end
