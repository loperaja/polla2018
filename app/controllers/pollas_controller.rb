class PollasController < ApplicationController
  before_action :set_polla, :only => [:edit, :update]
  before_action :set_wizard_step, :only => [:edit]

  def new
    @polla = Polla.new
    set_wizard_step
    case  @polla.wizard_step
    when "primera_fase"
      Match.all.each{|match| @polla.results.build(resultable_id: match.id, resultable_type: match.class.to_s)}
    when "posiciones"
      Round.where(step: @polla.wizard_step).each{|posit| @polla.results.build(resultable_id: posit.id, resultable_type: posit.class.to_s)}
    end
  end


  def create

  end


  def edit

  end

  def update

  end

  private

  def set_polla
    @polla = Polla.find(params[:id])
  end

  def set_wizard_step
    @polla.wizard_step = params[:step].present? ? params[:step] : @polla.wizard_step
  end

end
