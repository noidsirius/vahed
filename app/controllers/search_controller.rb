class SearchController < ApplicationController

  helper_method :persian_num
  def persian_num(num)
    persianNums={1=>"۱",2=>"۲",3=>"۳",4=>"۴",5=>"۵",6=>"۶",7=>"۷",8=>"۸",9=>"۹",0=>"۰"}
    s=""
    while num>=1
      s=persianNums[num%10]+s
      num=num/10
    end
    return s
  end
  
	def unit_search

        @courses = Array.new
        @majors = Major.where("title LIKE :major_title" , {:major_title =>"#{params[:major]}%"})
        course_title = params[:course_title]
        unless @majors
            #@majors = Array.new
            #@majors << -1
            @courses.concat(Course.where("( title LIKE :course_title OR content = :course_title )"  , {:course_title => "%#{course_title}%"}))
        else
          @majors.each do |t|
            #puts "AAAAAAAAA "
            #puts t.id
              #@courses.concat(Course.where("( title LIKE :course_title OR content = :course_title ) AND major_id= :major1" , {:course_title => "#{params[:course_title]}%" , :major1=> t.id}))
              @courses.concat(Course.where("( title LIKE :course_title OR content = :course_title ) AND major_id= :major1"  , {:course_title => "%#{course_title}%" , :major1 => t.id }))
          end
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
