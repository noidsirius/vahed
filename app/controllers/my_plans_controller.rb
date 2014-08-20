class MyPlansController < ApplicationController
	before_action :authenticate_user!
	def index
		@my_plans = Plan.where(:user_id => current_user.id).order("created_at DESC")
	end
end

