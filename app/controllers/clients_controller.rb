class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]


  #before_action :load_work #, only: [:new, :show, :edit, :create, :update]

  respond_to :html

  before_action :authenticate_user!
  
  before_filter :require_permission, except: [:index, :new, :create]

  def index
    #@clients = Client.all
    @clients = current_user.clients.paginate(:page => params[:page], :per_page => 50)
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

     def load_work
       @works = works.collect {|work| [work.start_time, work.end_time, work.title, work.description, work.billed, work.client_id]}
     end

      def require_permission
        if current_user != Client.find(params[:id]).user
          redirect_to root_path
          #Or do something else here
        end
      end


end
