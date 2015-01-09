class AddDetailToUnits < ActiveRecord::Migration
  def change
    add_column :units, :detail, :string
  end
end
