class HomeController < ApplicationController
  def index
    @pollas = Polla.all
    @pollas_count = @pollas.count
    @user_pollas = current_user.pollas
    @messages = Chat.order('created_at DESC').limit(50)
    @message = Chat.new
  end
end
