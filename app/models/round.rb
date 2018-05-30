class Round < ApplicationRecord

  has_many :results, as: :resultable

 def group
   (step == "posiciones") ? name.first : nil
 end

end
