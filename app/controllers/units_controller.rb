class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /units
  # GET /units.json
  def index
    @units = Unit.all
  end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    @unit = Unit.new
    @unit_time=UnitTime.new
    @unit_time_2=UnitTime.new
  end

  # GET /units/1/edit
  def edit
    @unit_time=@unit.unit_times[0]
    #@time_value="#{@unit_time.start_time.year}-#{@unit_time.start_time.month}-#{@unit_time.start_time.day} #{@unit_time.start_time.hour}:#{@unit_time.start_time.min}"
    if(@unit.unit_times.count>1)
      @unit_time_2=@unit.unit_times[1]
    end
  end

  # POST /units
  # POST /units.json
  def create
    go=true
    @unit = Unit.new(unit_params)
    unless params[:has_exam_date]
      @unit.exam_date=DateTime.new(1900,1,1)
    end
    @temp_1=@unit_time=UnitTime.new(:start_time => parse_time(params[:start_time]) , :end_time =>parse_time( params[:end_time]), :day => params[:day].to_i)
    if not @unit_time.save
      @temp_1=UnitTime.where(:start_time => parse_time(params[:start_time]) , :end_time =>parse_time( params[:end_time]), :day => params[:day].to_i)[0]
      if @temp_1.nil?
        puts "11111111111111111111111111111111"
        go=false
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @unit_time.errors, status: :unprocessable_entity }
        end
        return
      end
    end
    if params[:has_time_2] && go
      @temp_2=@unit_time_2=UnitTime.new(:start_time => parse_time(params[:start_time_2]) , :end_time =>parse_time( params[:end_time_2]), :day => params[:day_2].to_i)
      if not @unit_time_2.save
        @temp_2=UnitTime.where(:start_time => parse_time(params[:start_time_2]) , :end_time =>parse_time( params[:end_time_2]), :day => params[:day_2].to_i)[0]
        if @temp_2.nil?
          puts "22222222222222222222222222222"
          go=false
          respond_to do |format|
            format.html { render :new }
            format.json { render json: @unit_time_2.errors, status: :unprocessable_entity }
          end
          return
        end
      end
    end
    respond_to do |format|
      if go
        @unit.unit_times << @temp_1
        if params[:has_time_2]
          @unit.unit_times << @temp_2
        end
        if @unit.save
          format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
          format.json { render :show, status: :created, location: @unit }
        else
          format.html { render :new }
          format.json { render json: @unit.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    go=true
    #@unit = Unit.new(unit_params)
    @temp_1=@unit_time=UnitTime.new(:start_time => parse_time(params[:start_time]) , :end_time =>parse_time( params[:end_time]), :day => params[:day].to_i)
    if not @unit_time.save
      @temp_1=UnitTime.where(:start_time => parse_time(params[:start_time]) , :end_time =>parse_time( params[:end_time]), :day => params[:day].to_i)[0]
      if @temp_1.nil?
        go=false
      end
    end
    if params[:has_time_2] && go
      @temp_2=@unit_time_2=UnitTime.new(:start_time => parse_time(params[:start_time_2]) , :end_time =>parse_time( params[:end_time_2]), :day => params[:day_2].to_i)
      if not @unit_time_2.save
        @temp_2=UnitTime.where(:start_time => parse_time(params[:start_time_2]) , :end_time =>parse_time( params[:end_time_2]), :day => params[:day_2].to_i)[0]
        if @temp_2.nil?
          go=false
        end
      end
    end
    respond_to do |format|
      if go
        @unit.unit_times.clear
        @unit.unit_times << @temp_1
        if params[:has_time_2]
          @unit.unit_times << @temp_2
        end
        if @unit.update(unit_params)
          unless params[:has_exam_date]
            @unit.update(:exam_date => DateTime.new(1900,1,1))
          end
          format.html { redirect_to @unit, notice: 'Unit was successfully updated.' }
          format.json { render :show, status: :ok, location: @unit }
        else
          format.html { render :edit }
          format.json { render json: @unit.errors, status: :unprocessable_entity }
          format.json { render json: @unit_time.errors, status: :unprocessable_entity }
          format.json { render json: @unit_time_2.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to units_url, notice: 'Unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
      @unit_time = @unit.unit_times[1]
      @unit_time_2 = @unit.unit_times[2]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.permit(:start_time, :end_time, :day,:start_time_2,:end_time_2,:day_2,:has_time_2,:has_exam_date)
      params.require(:unit).permit(:exam_date, :capacity, :code , :professor_id , :course_id , :term_id, :detail)
    end
    
    def parse_time(hash)
      Time.parse("#{hash['time(1i)']}-#{hash['time(2i)']}-#{hash['time(3i)']} #{hash['time(4i)']}:#{hash['time(5i)']}")
    end
end
