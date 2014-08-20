class Requirements < ActiveRecord::Migration
  def change
  	create_table :requirement_connections , :id=>false do |s|
  		s.integer :course_a_id
  		s.integer :course_b_id
  	end
  end
end
