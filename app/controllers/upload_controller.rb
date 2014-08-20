class UploadController < ApplicationController
	before_action :authenticate_admin!
    def index
    end
	def upload_file
        post = DataFile.save(params[:upload])
		# uploaded_io = params[:document].original_filename
  #       dir='public/uploads'
  #       path = File.join(dir,uploaded_io)
  # 		path=File.open(Rails.root.join('public', 'uploads', uploaded_io), 'wb') do |file|
    	file.write(uploaded_io.read)
    	doc = Spreadsheet.open '#{path}'

    	majors=doc.worksheet 'majors'
    	terms=doc.worksheet 'terms'
    	professors=doc.worksheet 'professors'
    	units=doc.worksheet 'units'
    	courses=doc.worksheet 'courses'
    	fields=doc.worksheet 'fields'

    	if majors
    		majors.each do |row|
    			Major.create(row[0],row[1])
    		end
    	end

    	if terms
    		terms.each do |row|
    			Term.create(row[0],row[1])
    		end
    	end

    	if professors
    		professors.each do |row|
    			Professors.create(row[0])
    		end
    	end

    	if courses
    		courses.each do |row|
    			course=Course.new(row[0],row[1],Integer(row[2]),row[3])
    			major=Major.find_by_title(row[4])
    			course.major=major
    			course.save
    		end
    	end

    	if units
    		units.each do |row|
    			unit=Unit.new(row.datetime(0),Integer(row[1]),row[2])
    			course=Course.find_by_title(row[3])
    			prof=Professors.find_by_name(row[4])
    			term=Term.create(Integer(row[5]),Integer(row[6]))
                term=Term.where(:year=>Integer(row[5]),:section=>Integer(row[6]))[0]
                unit.course=course
                unit.professor=prof
                unit.term=term
    		end
    	end

    	if fields
    		fields.each do |row|
    			Field.create(row[0])
    		end
    	end
	end
end