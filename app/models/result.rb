class Result < ApplicationRecord
  include Abbreviations

  belongs_to :resultable, polymorphic: true
  belongs_to :polla
  #belongs_to :match, -> { where(results: {resultable_type: 'Match'}) }, foreign_key: 'resultable_id'
  #belongs_to :round, -> { where(results: {resultable_type: 'Round'}) }, foreign_key: 'resultable_id'
  #belongs_to :team, foreign_key: 'result'
  
  
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

  def team
    ((result == 0) ? abbr["Empate"] : abbr[Team.find(result).name]) if result
  end
    


end
