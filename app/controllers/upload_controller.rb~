class UploadController < ApplicationController
	before_action :authenticate_admin!

    def index
    end

    def format_file
        # book = Spreadsheet::Workbook.new
        # sheet1 = book.create_worksheet :name => ''
        # sheet1 = book.create_worksheet :name => ''
        # sheet1 = book.create_worksheet :name => ''
        # sheet1 = book.create_worksheet :name => ''
        # sheet1 = book.create_worksheet :name => ''
        # sheet1 = book.create_worksheet :name => ''

        # money_format = Spreadsheet::Format.new :number_format => "0.00 [$€-407]"
        # date_format = Spreadsheet::Format.new :number_format => 'DD.MM.YYYY'

        # # set default column formats
        # sheet1.column(1).default_format = money_format
        # sheet1.column(2).default_format = date_format
        # sheet1.row(0).push "just text", 5.98, DateTime.now
        # file = File.join(Rails.root, 'public', 'upload', 'test.xls')
        # book.write file
    end

    def parse_time(h,m)
        m=m*6
        puts "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr2000-02-02 #{h}:#{m}"
        t=Time.parse("2000-02-02 #{h}:#{m}")
        t = t+Integer(12600)
    end
    def better_y(s)
        return s.to_s.gsub("ي","ی")
    end

	def upload_file

        days = {9=>3,8=>2,7=>1,6=>0,5=>6}
        t ={"عصر"=>16,"صبح"=>8}

        Spreadsheet.client_encoding = 'UTF-8'
        file = File.join(Rails.root, 'public', 'upload', 'data.xls')
        doc = Spreadsheet.open file
        sheet = doc.worksheet 'sheet1'

        errors=Array.new

        #TODO set errors && betetr_y

        course = Course.new(:title => "u")
        prof = Professor.new(:name => "u")
        sheet.each do |row|
            unit = Unit.new
            if course.title != row[0].to_s
                course=Course.create(:title =>better_y(row[0]),:code => row[1].to_s,:unit_num => row[3].to_i)
                course=Course.where(:title =>better_y(row[0]),:code => row[1].to_s,:unit_num => row[3].to_i)[0]
                prof=Professor.create(:name => row[4].to_s)
                prof=Professor.where(:name => row[4].to_s)[0]
            end
            unit.professor=prof
            unit.course=course
            unit.code=row[2].to_s
            unit.term=Term.last
            unit.capacity=(row[12].to_s.match(/^\d+$/) ? row[12].to_i : 0)

            (5..9).each do |day|
                if row[day]
                    times=row[day].to_s.split("-")
                    start_t=times[0].split("/")
                    end_t=times[1].split("/")
                    unit_time=UnitTime.create(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])
                    unit_time=UnitTime.where(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                    #puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",parse_time(start_t[0].to_i,start_t[1].to_i ? start_t[1] : 0)
                    unit.unit_times<<unit_time
                end
            end

            if row[10]
                exam_day=row[10].to_s.split("/")[0]
                exam_hour=t[row[10].to_s.split("\n")[1]]
                unit.exam_date=DateTime.new(2015,01,exam_day,exam_hour,0)
            else
                unit.exam_date=DateTime.now
            end

            unless unit.save
                errors.concat(unit.errors.full_messages)
            end
        end

        errors.each do |e|
            puts "EEEEEEEEEERRRRRRRRRRRRROOOOOOOOOOOOORRRRRRRRRRRRR"
            puts e
        end


        # post = DataFile.save(params[:upload])
		# uploaded_io = params[:document].original_filename
        # dir='public/uploads'
        # path = File.join(dir,uploaded_io)
        # path=File.open(Rails.root.join('public', 'uploads', uploaded_io), 'wb') do |file|
    	#file.write(uploaded_io.read)
        # Spreadsheet.client_encoding = 'UTF-8'

        # book = Spreadsheet::Workbook.new
        # sheet1 = book.create_worksheet :name => 'test'

        # money_format = Spreadsheet::Format.new :number_format => "0.00 [$€-407]"
        # date_format = Spreadsheet::Format.new :number_format => 'DD.MM.YYYY'

        # # set default column formats
        # sheet1.column(1).default_format = money_format
        # sheet1.column(2).default_format = date_format
        # sheet1.row(0).push "just text", 5.98, DateTime.now
        # file = File.join(Rails.root, 'public', 'upload', 'test.xls')
        # book.write file
        # return

     #    Spreadsheet.client_encoding = 'UTF-8'
     #    file = File.join(Rails.root, 'public', 'upload', 'test.xls')
    	# doc = Spreadsheet.open file

    	# majors=doc.worksheet 'majors'
    	# terms=doc.worksheet 'terms'
    	# professors=doc.worksheet 'professors'
    	# units=doc.worksheet 'units'
    	# courses=doc.worksheet 'courses'
    	# fields=doc.worksheet 'fields'

    	# if majors
    	# 	majors.each do |row|
    	# 		Major.create(:title => row[0].to_s,:code => row[1].to_s)
    	# 	end
    	# end

    	# if terms
    	# 	terms.each do |row|
    	# 		Term.create(:year => Integer(row[0]),:section => Integer(row[1]))
    	# 	end
    	# end

    	# if professors
    	# 	professors.each do |row|
    	# 		Professor.create(:name => row[0].to_s)
    	# 	end
    	# end

    	# if courses
    	# 	courses.each do |row|
    	# 		course=Course.new(:title => better_y(row[0]),:content => better_y(row[1]),:unit_num => Integer(row[2]),:code => row[3].to_s)
    	# 		major=Major.find_by_title(better_y(row[4]))
    	# 		course.major=major
    	# 		course.save
    	# 	end
    	# end

     #    if fields
     #        fields.each do |row|
     #            Field.create(:title => row[0])
     #        end
     #    end


    	# if units
    	# 	units.each do |row|
     #            start_hour1=Integer(row[0])
     #            start_minute1=Integer(row[1])
     #            end_hour1=Integer(row[2])
     #            end_minute1=Integer(row[3])
     #            day1=Integer(row[4])
     #            @unit_time = UnitTime.create(:start_time => parse_time(start_hour1,start_minute1) , :end_time =>parse_time( end_hour1,end_minute1), :day => day1)
     #            @unit_time = UnitTime.where(:start_time => parse_time(start_hour1,start_minute1) , :end_time =>parse_time( end_hour1,end_minute1), :day => day1)[0]
     #            unless row[5]=="-"
     #                start_hour2=Integer(row[5])
     #                start_minute2=Integer(row[6])
     #                end_hour2=Integer(row[7])
     #                end_minute2=Integer(row[8])
     #                day2=Integer(row[9])
     #                @unit_time_2 = UnitTime.create(:start_time => parse_time(start_hour2,start_minute2) , :end_time =>parse_time( end_hour2,end_minute2), :day => day2)
     #                @unit_time_2 = UnitTime.where(:start_time => parse_time(start_hour2,start_minute2) , :end_time =>parse_time( end_hour2,end_minute2), :day => day2)[0]
     #            end
     #            if  (not @unit_time) || ((row[5] != "")&& (not @unit_time_2))
     #                next
     #            end
     #            exam_date=row.datetime(10)
     #            code=row[11]
     #            capacity=row[12]
     #            course=Course.find_by_title(row[13])
     #            prof=Professor.find_by_name(row[14])
    	# 		term=Term.create(:year => Integer(row[15]),:section => Integer(row[16]))
     #            term=Term.where(:year=>Integer(row[15]),:section=>Integer(row[16]))[0]
     #            @unit=Unit.new(:exam_date => exam_date,:capacity => capacity,:code => code)
     #            @unit.course=course
     #            @unit.professor=prof
     #            @unit.term=term
     #            @unit.unit_times<<@unit_time
     #            if @unit_time_2
     #                @unit.unit_times<<@unit_time_2
     #            end
     #            @unit.save
    	# 	end
    	# end
	end
end 

