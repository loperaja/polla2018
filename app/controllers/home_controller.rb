class HomeController < ApplicationController
  def index
    @pollas = Polla.where(real: false).order('points DESC')
    @pollas_count = @pollas.count
    @user_pollas = current_user.pollas
    @messages = Chat.order('created_at ASC').limit(50)
    @message = Chat.new
  end
end
