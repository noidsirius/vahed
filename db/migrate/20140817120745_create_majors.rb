class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
  end
end
