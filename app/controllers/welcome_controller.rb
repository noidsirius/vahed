class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to plans_dashboard_path
    end
  end
  def join_acm
    @recruit = Recruit.new
    @vahed = Recruit.where("category = 'Vahed' and user_id = ?", current_user.id).first
    @f1 = Recruit.where("category = 'F1' and user_id = ?", current_user.id).first

  end
end
