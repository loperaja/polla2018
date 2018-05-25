class Result < ApplicationRecord

  belongs_to :resultable, polymorphic: true
  belongs_to :polla
  
  def group
    Match.find(self.match_id).group

  end

end
