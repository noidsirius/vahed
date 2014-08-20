class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.text :content
      t.boolean :shared
      t.integer :score
      t.integer :term_id
      t.integer :user_id
      t.integer :field_id

      t.timestamps
    end
  end
end
