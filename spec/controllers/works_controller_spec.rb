require 'rails_helper'

RSpec.describe WorksController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Work. As you add validations to Work, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WorksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all works as @works" do
      work = Work.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:works)).to eq([work])
    end
  end

  describe "GET show" do
    it "assigns the requested work as @work" do
      work = Work.create! valid_attributes
      get :show, {:id => work.to_param}, valid_session
      expect(assigns(:work)).to eq(work)
    end
  end

  describe "GET new" do
    it "assigns a new work as @work" do
      get :new, {}, valid_session
      expect(assigns(:work)).to be_a_new(Work)
    end
  end

  describe "GET edit" do
    it "assigns the requested work as @work" do
      work = Work.create! valid_attributes
      get :edit, {:id => work.to_param}, valid_session
      expect(assigns(:work)).to eq(work)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Work" do
        expect {
          post :create, {:work => valid_attributes}, valid_session
        }.to change(Work, :count).by(1)
      end

      it "assigns a newly created work as @work" do
        post :create, {:work => valid_attributes}, valid_session
        expect(assigns(:work)).to be_a(Work)
        expect(assigns(:work)).to be_persisted
      end

      it "redirects to the created work" do
        post :create, {:work => valid_attributes}, valid_session
        expect(response).to redirect_to(Work.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved work as @work" do
        post :create, {:work => invalid_attributes}, valid_session
        expect(assigns(:work)).to be_a_new(Work)
      end

      it "re-renders the 'new' template" do
        post :create, {:work => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested work" do
        work = Work.create! valid_attributes
        put :update, {:id => work.to_param, :work => new_attributes}, valid_session
        work.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested work as @work" do
        work = Work.create! valid_attributes
        put :update, {:id => work.to_param, :work => valid_attributes}, valid_session
        expect(assigns(:work)).to eq(work)
      end

      it "redirects to the work" do
        work = Work.create! valid_attributes
        put :update, {:id => work.to_param, :work => valid_attributes}, valid_session
        expect(response).to redirect_to(work)
      end
    end

    describe "with invalid params" do
      it "assigns the work as @work" do
        work = Work.create! valid_attributes
        put :update, {:id => work.to_param, :work => invalid_attributes}, valid_session
        expect(assigns(:work)).to eq(work)
      end

      it "re-renders the 'edit' template" do
        work = Work.create! valid_attributes
        put :update, {:id => work.to_param, :work => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested work" do
      work = Work.create! valid_attributes
      expect {
        delete :destroy, {:id => work.to_param}, valid_session
      }.to change(Work, :count).by(-1)
    end

    it "redirects to the works list" do
      work = Work.create! valid_attributes
      delete :destroy, {:id => work.to_param}, valid_session
      expect(response).to redirect_to(works_url)
    end
  end

end
