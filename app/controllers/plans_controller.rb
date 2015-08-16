class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:show, :edit,:update, :destroy, :index]
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
     
      @plans = Plan.where(:user_id => current_user.id).order("updated_at DESC") if user_signed_in?
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  def dashboard

    #render :text => "Sas"
    @plans = Plan.where(:user_id => current_user.id).where("created_at >= ?",Date.new(Date.now.year,1,1)) if user_signed_in?
    if current_admin
      @plans = Plan.all
    end
    @majors = Major.all
    @first_plan = 0
    #if @plans.count > 0
    #  first_plan = @plans.first.id
    #end
    #puts "SSS"
    #puts params[:plan_id]
    if params[:plan_id]
      @first_plan = params[:plan_id]
    end
  end

  def show_pdf
    #render text: "<table> <tr><th>SASL</th></tr>"
    #return
    @plan = Plan.find_by_id(params[:id])
    @go = false
    if @plan and (current_admin or @plan.user == current_user)
      @go = true
    end
    if @go == false
      redirect_to plans_dashboard_path, :notice => "You don't have access to this plan"
      return
    end
    render layout: false
  end

  # def alaki
  #   @units = Unit.all
  # end

  # def alaki2
  #   @unit = Unit.find(params[:id])
  #   if params[:id] == "2"
  #       @error = "akhakha"
  #   end
  # end


  def switch
    @plan = Plan.find_by_id(params[:id])
    @profile = current_user.profile
    @go = false
    if @plan and (current_admin or @plan.user == current_user)
      @go = true
    end
  end


  # GET /plans/new
  def new
    @plan = Plan.new
    @go=false
  end

  # GET /plans/1/edit
  def edit
    @go = true
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    if user_signed_in?
      current_user.plans << @plan
    end
    respond_to do |format|
      if @plan.save
        format.html { redirect_to :action => :dashboard, plan_id: @plan }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.js {}
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:title, :content, :shared,:term_id, :field_id, :unit_ids => [])
    end
end