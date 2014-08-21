class Plan < ActiveRecord::Base
	validates :user_id , :presence => true
	validates :field_id , :presence => true

	after_initialize :default_values
	
	has_and_belongs_to_many :units
	belongs_to :term
	belongs_to :user
	belongs_to :field


	def check_all(unit)
		if(check_multiple_courses(unit))
			return check_overlap(unit)
		end
		return false
	end

	def check_multiple_courses(t)
         	units.each do |s|
         		if t.course_id == s.course_id
            		errors.add(:base , "#{s.title} در برنامه ی شما وجود دارد")
            		return false
            	end
         end
         return true
    end
                

  	def default_values
    	title ||= 'untitled'
  	end

	def check_overlap(t)
		flag = true
			units.each do |s|
					if t.exam_date.to_f!=DateTime.new(1900,1,1).to_f && t.exam_date.to_f == s.exam_date.to_f
						errors.add(:base , " زمان امتحان #{t.title} و #{s.title} با هم تداخل دارند  ")
						flag = false
					end

					t.unit_times.each do |x|
						s.unit_times.each do |y|
		  					if x.day == y.day && (x.start_time.to_f <= y.end_time.to_f) && (x.end_time.to_f >= y.start_time.to_f)
		  						errors.add(:base , "#{t.title} و #{s.title} تداخل زمانی دارند ")
								flag = false;
		  					end
						end
				
				end
			end
			return flag
		end
end

def sum_unit_num
  sum = 0
  units.each do |u|
    sum += u.unit_num
  end
  return sum

end

