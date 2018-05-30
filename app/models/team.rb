class Team < ApplicationRecord

  validates_uniqueness_of :name

  def matches
    Match.where("home_team_id = #{id} or away_team_id = #{id}")
  end


end
