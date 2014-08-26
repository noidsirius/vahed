class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.text :content

      t.timestamps
    end
  end
end
