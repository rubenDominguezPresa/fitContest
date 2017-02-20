class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :description
      t.string :rules
      t.attachment :image
      t.timestamps null: false
    end
  end
end
