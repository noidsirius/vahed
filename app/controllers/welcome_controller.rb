class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to "http://acm.ut.ac.ir/vahed/plans/dashboard"
    end
  end
end
