class Term < ActiveRecord::Base
	validates :year, :presence => true
	validates :section, :presence => true
	validates :section ,:inclusion =>{ :in => 1..3}
	validates :year, :uniqueness => {:scope => :section}

	has_many :units
	has_many :plans
end

