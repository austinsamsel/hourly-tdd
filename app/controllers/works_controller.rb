class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  #before_action :load_clients, only: [:new, :edit, :create, :update]

  before_action :find_client

  respond_to :html

  before_action :authenticate_user!

  def index
    
    @works = @client.works
    respond_with(@works)
  end

  def show
    respond_with(@work)
  end

  def new
    @work = @client.works.build
    respond_with(@work)
  end

  def edit
    @work = @client.works.find(params[:id])
  end

  def create
    @work = @client.works.create(work_params)
    @work.save
    respond_with(@work.client, @work)
  end

  def update
    @work = @client.works.find(params[:id])
    respond_with(@work.client, @work)
  end

  def destroy
    @work.destroy
    respond_with(@work.client, @work)
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:start_time, :end_time, :title, :description, :billed, :client_id)
    end

    def load_clients
      @clients = current_user.clients.collect {|client| [client.name, client.id]}
    end

    def find_client
      @client = Client.find(params[:client_id])
    end

end
