class PlansUnitsJoin < ActiveRecord::Migration
  def change
  	create_table :plans_units , :id=>false do |p|
  		p.integer :plan_id
  		p.integer :unit_id
  	end
  end
end
