class AddFinishedToPlans < ActiveRecord::Migration
  def change
  	add_column :plans, :finished, :boolean,:default => false
  end
end
