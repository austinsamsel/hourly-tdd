require 'rails_helper'

describe WorksController do

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
        @client = create(:client) 
        login_with create( :user )
        get :index, client_id: @client.id
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested work to @work" do
      work = create(:work)
      get :show, id: work
      expect(assigns(:work)).to eq work
    end
    it "renders the :show template" do
      login_with create( :user )
      work = create(:work)
      get :show, id: work
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new work to @work" do
      login_with create(:user)
      get :new
      expect(assigns(:work)).to be_a_new(Work)
    end
    it "renders the :new template" do
      login_with create(:user)
      get :new
      expect(response).to render_template :new
    end
    it "only shows current user's services"
  end

  describe 'GET #edit' do
    it "assigns the requested work to @work" do
      login_with create(:user)
      work = create(:work)
      get :edit, id: work
      expect(assigns(:work)).to eq work
    end
    it "renders the :edit template" do
      login_with create(:user)
      work = create(:work)
      get :edit, id: work
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new work in the database" do
        login_with create(:user)
        expect{
          post :create, work: attributes_for(:work)
        }.to change(Work, :count).by(1)
      end
      it "redirects to works#show" do
        login_with create(:user)
        post :create, work: attributes_for(:work)
        expect(response).to redirect_to work_path(assigns[:work])
      end
    end
    context "with invalid attributes" do
      it "does not save the new work in the database" do
        login_with create(:user)
        expect{
          post :create,
          work: attributes_for(:invalid_work)
        }.not_to change(Work, :count)
      end
      it "re-renders the :new template" do
        login_with create(:user)
        post :create,
          work: attributes_for(:invalid_work)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @work = create(:work,
        title: 'Bro and Bro, Inc.')
      login_with create(:user)
    end
    context "with valid attributes" do
      it "locates the requested @work" do
        patch :update, id: @work, work: attributes_for(:work)
        expect(assigns(:work)).to eq(@work)
      end
      it "changes @work's attributes" do
        patch :update, id: @work,
          work: attributes_for(:work,
            title: 'The Bros, Inc.')
        @work.reload
        expect(@work.title).to eq('The Bros, Inc.')
      end
      it "redirects to the updated work" do
        patch :update, id: @work, work: attributes_for(:work)
        expect(response).to redirect_to @work
      end
    end
    context "with invalid attributes" do
      it "does not change the work's attributes" do
        patch :update, id: @work,
          work: attributes_for(:work,
            title: nil)
        @work.reload
        expect(@work.title).not_to eq(nil)
      end
      it "re-renders the :edit template" do
        patch :update, id: @work,
          work: attributes_for(:invalid_work)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @work = create(:work)
      login_with create(:user)
    end
    it "deletes the work" do
      expect{
        delete :destroy, id: @work
      }.to change(Work, :count).by(-1)
    end
    it "redirects to users#index" do
      delete :destroy, id: @work
      expect(response).to redirect_to works_url
    end
  end
end
