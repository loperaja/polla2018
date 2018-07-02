class ResultsController < ApplicationController
  def index
    res = Result.includes(:resultable).includes(:polla)
    teams = Team.select(:id, :name).each_with_object({}){|t,h| h[t.id] = t.short_name}
    teams[0] = "E"
    @results = res.each_with_object({}) do |e, h|
      aux={e.resultable_type => {e.resultable.name => teams[e.result]}}
      (h[e.polla.name]||={})[e.resultable_type]||={}
      (h[e.polla.name][e.resultable_type][e.resultable.name]||=[]) << aux[e.resultable_type][e.resultable.name]
    end
    @real = @results.delete("la de verda")
    @matches = Match.includes(:home_team).includes(:away_team)
    rounds = Round.all
    @group_pos = rounds.where('name NOT IN (?)', ['OCTAVOS', 'CUARTOS', 'SEMIS', 'CAMPEON', 'SEGUNDO', 'TERCERO', 'CUARTO', 'GOLEADOR', 'MASGOLEADO'])
    @rounds = rounds.where('name IN (?)', ['OCTAVOS', 'CUARTOS', 'SEMIS', 'CAMPEON', 'SEGUNDO', 'TERCERO', 'CUARTO'])
  end
end
