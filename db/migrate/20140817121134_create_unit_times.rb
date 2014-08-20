class CreateUnitTimes < ActiveRecord::Migration
  def change
    create_table :unit_times do |t|
      t.time :start_time
      t.time :end_time
      t.integer :day

      t.timestamps
    end
  end
end
