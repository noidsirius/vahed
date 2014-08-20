class Professor < ActiveRecord::Base
	validates :name, :presence => true
	validates :name, :uniqueness => true
	has_many :units
end

