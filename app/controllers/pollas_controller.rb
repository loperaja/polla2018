class PollasController < ApplicationController
  before_action :set_polla, :only => [:edit, :update]
  before_action :user_polla_validation, :except => [:new, :create]
  before_action :set_wizard_step, :only => [:edit]
  before_action :check_time, only: [:new, :edit, :create, :update]

  def new
    @polla = current_user.pollas.new
    results_builder
  end


  def create
    @polla = current_user.pollas.new(polla_attributes)
    if @polla.save
      redirect_to edit_polla_path(@polla.id)
    else 
      @polla.wizard_step = @polla.previous_step
      round_details
      render 'new'
    end
  end


  def edit
    results_builder
  end

  def update
    if @polla.update_attributes(polla_attributes)
      if @polla.finish
        redirect_to home_index_path
      else
        results_builder
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def show
    @polla = Polla.find(params[:id])
  end

  def destroy
    Polla.find(params[:id]).destroy
    flash[:notice] = "Polla eliminada" 
    redirect_to home_index_path
  end

  private

  def polla_attributes
  params.require(:polla)
        .permit(:id,
	        :wizard_step,
	        :finish,
	        :name, 
		:team_ids => [], 
		:results_attributes => [:id, :resultable_id, :resultable_type, :result, :_destroy])
  end

  def set_polla
    @polla = Polla.find(params[:id])
  end

  def set_wizard_step
    @polla.wizard_step = params[:step].present? ? params[:step] : @polla.wizard_step
  end

  def round_details
   if @polla.wizard_step == "primera_fase"
     @round = Match.order(:id)
   else
     @round =  Round.where(step: @polla.wizard_step)
   end
  end

  def user_polla_validation
    redirect_to dashboards_path if current_user != @polla.user 
  end

  def results_builder
    set_wizard_step
    round_details
    case  @polla.wizard_step
    when "primera_fase", "posiciones", "final"
      @round.each{|r| @polla.results.find_or_initialize_by(resultable_id: r.id, resultable_type: r.class.to_s)}
    end
  end

  def check_time
    first_match_time = Time.parse("Jun 14, 2018 3:00 PM UTC")
    if (Time.zone.now > first_match_time) && !@polla.real? && @polla.name = "MrChrimes"
      flash[:notice] = "Se le acabó el tiempo!"
      redirect_to home_index_path
    end
  end

end
