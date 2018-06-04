class HomeController < ApplicationController
  def index
    @pollas = Polla.all
    @pollas_count = @pollas.count
    @user_pollas = current_user.pollas
  end
end
