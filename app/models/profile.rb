class Profile < ActiveRecord::Base
  belongs_to :user
  validates :student_no, :presence => true, :numericality => { greater_than_or_equal_to: 810188000, less_than_or_equal_to: 810193999}
  validates :entrance_year, :presence => true, :numericality => { greater_than_or_equal_to: 88, less_than_or_equal_to: 93}
end
