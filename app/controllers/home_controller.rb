class HomeController < ApplicationController
  def index
    @pollas = Polla.where(real: false).order('points DESC')
    stats = points_stats
    @today_points = stats[:today]
    @yesterday_points = stats[:yesterday]
    @pollas_count = @pollas.count
    @user_pollas = current_user.pollas
    @messages = Chat.order('created_at DESC').limit(50).reverse
    @message = Chat.new
  end

  private 
  
  def points_stats
    today = Time.zone.today
    yesterday = (today - 1.day)
    return {today: point_history(today), yesterday: point_history(yesterday)}
  end

  def point_history(date)
    begin
      ph = PointHistory
        .select('polla_id, sum(points_awarded) AS points')
        .group('polla_id')
        .where('created_at BETWEEN ? AND ?', date.beginning_of_day, date.end_of_day)
      return ph.each_with_object({}){|p,h| h[p.polla_id] = p.points}
    rescue
      {}
    end
  end

end
