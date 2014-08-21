class SearchController < ApplicationController
	def unit_search

        @courses = Array.new
        @majors = Major.where("title LIKE :major_title" , {:major_title =>"#{params[:major]}%"})
        unless @majors
            @majors = Array.new
            @majors << -1
        end
        @majors.each do |t|
          #puts "AAAAAAAAA "
          #puts t.id
            #@courses.concat(Course.where("( title LIKE :course_title OR content = :course_title ) AND major_id= :major1" , {:course_title => "#{params[:course_title]}%" , :major1=> t.id}))
            @courses.concat(Course.where("( title LIKE :course_title OR content = :course_title ) AND major_id= :major1"  , {:course_title => "%#{params[:course_title]}%" , :major1 => t.id }))
        end
        @courses=@courses.uniq            
        #puts "Ssssssssssssss"
        #puts @courses.count
        @units = Array.new
        @courses.each do |s|
           	@units.concat(Unit.where(:course_id => s.id))
        end
        @units = @units.uniq
        #render "search/unit_search"
	end
end
