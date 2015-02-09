class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  #before_action :load_work, only: [:new, :show, :edit, :create, :update]

  respond_to :html

  before_action :authenticate_user!

  def index
    #@clients = Client.all
    @clients = current_user.clients
    respond_with(@clients)
  end

  def show
    @works = current_user.works
    respond_with(@client)
  end

  def new
    @client = Client.new
    respond_with(@client)
  end

  def edit
  end

  def create
    @client = current_user.clients.build(client_params)
    @client.save
    respond_with(@client)
  end

  def update
    @client.update(client_params)
    respond_with(@client)
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name, :user_id)
    end

    # def load_work
    #   @works = current_user.works.collect {|work| [work.start_time, work.end_time, work.title, work.description, work.billed, work.client_id]}
    # end
end
