class PollasController < ApplicationController

  def new
    @polla = Polla.new
    Match.all.each{|match| @polla.results.build(resultable_id: match.id, resultable_type: "Match")}
    @group = "A"
  end


  def create

  end

end
