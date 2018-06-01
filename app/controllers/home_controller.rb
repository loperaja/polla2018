class HomeController < ApplicationController
  def index
    @all_pollas = Polla.all
    @user_pollas = current_user.pollas
  end
end
