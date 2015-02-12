class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  before_action :load_clients, only: [:new, :edit, :create, :update]

  respond_to :html

  before_action :find_client, except: [:index, :show]

  before_action :authenticate_user!
  before_filter :require_permission, except: [:index, :new, :create]
  #before_filter :index_permission, only: [:index, :new]

  def index
    @works = current_user.works
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
  end

  def create
    @work = @client.works.build(work_params)
    @work.save
    respond_with(@work)
  end

  def update
    @work.update(work_params)
    respond_with(@work)
  end

  def destroy
    @work.destroy
    respond_with(@work)
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:start_time, :end_time, :title, :description, :billed, :client_id)
    end

    def find_client
      @client = Client.find(params[:client_id])
    end

    def load_clients
      @clients = current_user.clients.collect {|client| [client.name, client.id]}
    end

    def require_permission
      if current_user != Work.find(params[:client_id]).user
        redirect_to root_path
        #Or do something else here
      end
    end

    def index_permission
      if current_user != Client.find(params[:client_id]).user
        redirect_to root_path
        #Or do something else here
      end
    end

end
