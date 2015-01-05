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
    @ar = Recruit.where("category = 'AR' and user_id = ?", current_user.id).first
    @contest = Recruit.where("category = 'Contest' and user_id = ?", current_user.id).first

  end
end
