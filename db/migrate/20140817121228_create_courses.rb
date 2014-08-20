class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :content
      t.integer :unit_num
      t.string :code
      t.integer :major_id

      t.timestamps
    end
  end
end
