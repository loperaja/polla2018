class Polla < ApplicationRecord
  has_many :results, :dependent => :destroy
  belongs_to :user
  validates_presence_of :wizard_step, :name
  
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
   (100*self.results.count)/112
  end

end
