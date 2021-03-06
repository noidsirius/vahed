class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index, :show, :edit, :update, :destroy]
  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
    if params[:plan]
      @plans = current_user.plans
    elsif params[:unit]
      @units = Unit.where(:finished=>false)
    elsif params[:default]
      @default = true
    end
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user = current_user
    respond_to do |format|
      if @report.save
        Admin.all.each do |ad|
          UserMailer.send_report(ad, @report).deliver
        end
        format.html { redirect_to plans_dashboard_path, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        if @report.reportable_type == "Plan"
          @Plan = current_user.plans
          format.html { render :new, :locals => {:plan => :true} }
        elsif @report.reportable_type == "Unit"
          @units = Unit.where(:finished=>false)
          format.html { render :new, :locals => {:plan => :true} }
        elsif @report.reportable_type == "Default"
          @default = true
          format.html { render :new, :locals => {:plan => :true} }
        else
          format.html { render :new, :locals => {:plan => :true} }
        end
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:content, :reportable_type, :reportable_id)
  end
end
