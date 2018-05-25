class Team < ApplicationRecord

  def matches
    Match.where("home_team_id = #{id} or away_team_id = #{id}")
  end


end
