class UnitTime < ActiveRecord::Base
	validate :valid_time

	validate :day,:presensce=>true
	validate :start_time,:presensce=>true
	validate :end_time,:presensce=>true
	validates :day ,:inclusion =>{ :in => 0..6}
	validates :day, :uniqueness => {:scope => [:start_time, :end_time]}

	has_and_belongs_to_many :units 
	
	def  valid_time
		errors.add(:unit_time,"End time must be greater than start time") unless end_time.to_f>start_time.to_f
	end
end
