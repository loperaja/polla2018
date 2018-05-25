class Match < ApplicationRecord

  has_many :results, as: :resultable
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"

  delegate :group, to: :home_team


  def self.by_group
    teams = Team.select([:id, :group]).group_by(&:group)
    teams.keys.each_with_object({}) {|group, hsh| hsh[group] = Match.where({:home_team => teams[group].map(&:id), :away_team => teams[group].map(&:id)})}
  end

  def home_team_name
    home_team.try(:name)
  end

  def away_team_name
    away_team.try(:name)
  end

  def result_options
    [["Seleccione", nil], [home_team_name, home_team.id], [away_team_name, away_team.id], ["Empate", 0]]
  end

  def title
    "#{home_team_name} vs #{away_team_name}"
  end


end
