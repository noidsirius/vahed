class CreateRecruits < ActiveRecord::Migration
  def change
    create_table :recruits do |t|
      t.references :user, index: true
      t.string :category

      t.timestamps
    end
  end
end
