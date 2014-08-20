class SharedPlansController < ApplicationController
	def last_plans
		@plans = Plan.where(:shared => true).order("created_at DESC")
	end
	def best_plans
		@plans = Plan.where(:shared => true).order("score DESC")
	end
end

