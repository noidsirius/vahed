class Major < ActiveRecord::Base
	validates :title, :presence => true
	validates :title, :uniqueness => true
	validates :code, :presence => true
    validates :code, :uniqueness => true
    validates :code, format: { with: /[0-9]/, message: "only allows numbers" }
    validates :code, length: {minimum: 4, maximum: 4}
	has_many :courses
end
