class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.datetime :exam_date
      t.integer :capacity
      t.string :code
      t.integer :course_id
      t.integer :professor_id
      t.integer :term_id

      t.timestamps
    end
  end
end
