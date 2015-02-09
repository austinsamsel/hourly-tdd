class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  before_action :load_clients, only: [:new, :edit, :create, :update]

  respond_to :html

  before_action :authenticate_user!

  def index
    @works = current_user.works
    respond_with(@works)
  end

  def show
    respond_with(@work)
  end

  def new
    @work = Work.new
    respond_with(@work)
  end

  def edit
  end

  def create
    @work = current_user.works.build(work_params)
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

    def load_clients
      @clients = current_user.clients.collect {|client| [client.name, client.id]}
    end

end
