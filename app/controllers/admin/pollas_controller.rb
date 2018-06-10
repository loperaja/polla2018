class Admin::PollasController < Admin::AdminController

  def index
    @pollas = Polla.all.order(:name)
  end

  def update
    Polla.find(params[:id]).update_attributes(:paid => params[:paid])
    @pollas = Polla.all.order(:name)
    render :index
  end

end
