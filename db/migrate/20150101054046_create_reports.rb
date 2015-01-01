class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :content
      t.string :reportable_type
      t.integer :reportable_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
