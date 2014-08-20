class Prerequisites < ActiveRecord::Migration
  def change
  	create_table :prerequisite_connections , :id=>false do |s|
  		s.integer :course_a_id
  		s.integer :course_b_id
  	end
  end
end
