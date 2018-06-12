class Polla < ApplicationRecord
  has_many :results, :dependent => :destroy
  has_many :point_histories, :dependent => :destroy
  belongs_to :user
  validates_presence_of :wizard_step, :name
  after_save :add_points, if: :real?
  
  accepts_nested_attributes_for :results, allow_destroy: true

  WIZARD_STEPS = {"primera_fase" => 1, "posiciones" => 2, "octavos" => 3, "cuartos" => 4, "semis" => 5, "final" => 6}
  enum wizard_step: WIZARD_STEPS.keys

  attr_accessor :finish


  def next_step
    steps = WIZARD_STEPS.keys
    step = steps.index(self.wizard_step)
    next_step = (steps.index(steps.last) == step) ? 0 : (step + 1)
    steps[next_step]
  end 

  def previous_step
    step = WIZARD_STEPS[self.wizard_step]
    step == 1 ? WIZARD_STEPS.key(step) : WIZARD_STEPS.key(step - 1)
  end

  def team_ids
    round = Round.find_by(step: wizard_step)
    results = round.results.where(polla_id: self.id)
    if results
      return results.map(&:result)
    else
      return nil
    end
  end

  def team_ids=(ids)
    round = Round.where(step: previous_step).try(:first)
    if round && ids
      team_ids = Team.all.map(&:id)
      ids = ids.reject(&:empty?)
      not_selected_ids = team_ids - ids.map(&:to_i)
      self.results.where(result: not_selected_ids, resultable_id: round.id, resultable_type: round.class.to_s).destroy_all
      ids.each do |team_id|
        self.results.find_or_initialize_by(resultable_id: round.id, resultable_type: round.class.to_s, result: team_id.to_i)
      end
    end
  end

  def progress
   (100*self.results.where("result IS NOT ?", nil).count)/112
  end

  def points_report
    report_str = ''
    point_histories.order('points ASC').each do |h|
      report_str+="#{h.result.resultable.name} puso #{(h.result.result == 0) ? "Empate" : Team.find(h.result.result).name} y quedo con #{h.points} puntos "
    end
    return report_str
  end

  private

  def add_points
    self.results.where('result is NOT ? AND added = ?', nil, false).each do |result|
      aciertos = Result.where(
       :resultable_id => result.resultable_id,
       :resultable_type => result.resultable_type,
       :added => false,
       :result => result.result
      )
      aciertos = aciertos.select{|a| a !=result}
      aciertos.each do |acierto|
        acierto.update_attributes(added: true)
        polla = acierto.polla
	added_points = (acierto.resultable_type == "Match") ? 1 : acierto.resultable.points
	points = polla.points.to_i + added_points
	polla.update_attributes(points: points) unless polla.real?
        PointHistory.create!(polla_id: polla.id, result_id: result.id, points: points)
     end
     result.update_attributes(added: true)
   end
 end

end
