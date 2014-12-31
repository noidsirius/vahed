class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :second_name
      t.integer :entrance_year
      t.integer :student_no
      t.references :user, index: true

      t.timestamps
    end
  end
end
