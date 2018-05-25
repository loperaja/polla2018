class Polla < ApplicationRecord
  has_many :results, :dependent => :destroy
  
  accepts_nested_attributes_for :results

  WIZARD_STEPS = {"primera_fase" => 1, "posiciones" => 2, "octavoss" => 2, "cuartoss" => 3, "semis" => 4}
  enum wizard_step: WIZARD_STEPS.keys


   def next_step
    steps = WIZARD_STEPS.keys
    steps[steps.index(self.wizard_step) + 1]
  end 

  def previous_step
    step = WIZARD_STEPS[self.wizard_step]
    step == 1 ? WIZARD_STEPS.key(step) : WIZARD_STEPS.key(step - 1)
  end 

end
