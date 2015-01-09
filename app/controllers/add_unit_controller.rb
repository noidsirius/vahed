class AddUnitController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authenticate_user!
	def index
		@unit=Unit.find_by_id(params[:unit_id].to_i)
		@plan=Plan.find_by_id(params[:plan_id].to_i)
    @profile = current_user.profile
		unless @plan
			@go=false
			@plan=Plan.new
      if params[:plan_id] == '0' and current_user.plans.count > 0
        @plan.errors.add(:base,"لطفا یکی از برنامه‌ها را انتخاب کنید.")
      else
        @plan.errors.add(:base,"لطفا ابتدا برنامه جدید بسازید")
      end
		else
			if @plan.user.id==current_user.id && @plan.check_all(@unit)
				@plan.units<<@unit
				@go=true
			else
				@go=false
			end
		end
		
	end
	def delete_unit
		@unit = Unit.find_by_id(params[:unit_id].to_i)
		@plan = Plan.find_by_id(params[:plan_id].to_i)
    unless @plan
      @go=false
      @plan=Plan.new
      @plan.errors.add(:base,"لطفا ابتدا برنامه جدید بسازید")
    else
      if @plan.user.id==current_user.id
        @plan.units.destroy(@unit)
        @go=true
      else
        @go=false
      end
    end
	end
end
