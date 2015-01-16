class Unit < ActiveRecord::Base

	validate :check_times_differ
	#validate :has_unit_time

	validates :exam_date, :presence => true
	validates :capacity, :presence => true
	validates :professor_id, :presence => true
	validates :course_id, :presence => true
	validates :term_id, :presence => true
	validates :capacity, :inclusion =>{ :in => 0..200}
	validates :code, :presence => true
    validates :code, format: { with: /[0-9]/, message: "only allows numbers" }
    validates :code, length: {minimum: 1, maximum: 3}

	belongs_to :professor
	belongs_to :course
	belongs_to :term
	has_and_belongs_to_many :unit_times
	has_and_belongs_to_many :plans
	delegate :start_times, to: :unit_times
	delegate :end_times, to: :unit_times
	delegate :title , to: :course
  delegate :unit_num , to: :course

  def has_unit_time
	  errors.add(:unit_time, 'must have at least one unit time') if unit_times.blank?
	end
	def check_times_differ
		errors.add(:unit_time,"Times should differ") unless unit_times.uniq.length==unit_times.length
  end
  def registered_count entrance_year
    plans.joins(user: { profile: :user}).where( "profiles.entrance_year <= ?", entrance_year).select(:user_id).distinct.count
  end
  def to_string
    course.title + " - " + professor.name + " - " + code.to_s
  end
end

