class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to "/plans/dashboard"
    end
  end
end
