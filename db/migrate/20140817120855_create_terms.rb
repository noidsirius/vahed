class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :year
      t.integer :section

      t.timestamps
    end
  end
end
