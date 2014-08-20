class UnitTimesUnitsJoin < ActiveRecord::Migration
  def change
  	create_table :unit_times_units , :id => false do |t|
  		t.integer :unit_time_id , :null => false
  		t.integer :unit_id , :null => false
  	end
  end
end
