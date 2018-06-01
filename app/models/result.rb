class Result < ApplicationRecord

  belongs_to :resultable, polymorphic: true
  belongs_to :polla
  
  validates_uniqueness_of :result, scope: [:resultable_id, :polla_id, :resultable_type]

  MATCHES_PER_GROUP = 6
  
  def group
    case resultable_type
    when "Match"
      resultable.try(:group)
    when "Round"
      resultable.name.try(:first)
    else
      nil
    end
  end

  def position_teams_options
    Team.where(group: group).map{|team| [team.name, team.id]}
  end
    


end
