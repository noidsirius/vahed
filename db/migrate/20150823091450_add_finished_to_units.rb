class AddFinishedToUnits < ActiveRecord::Migration
  def change
  	add_column :units, :finished, :boolean,:default => false
  end
end
