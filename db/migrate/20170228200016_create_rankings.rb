class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :user, index: true
      t.references :challenge, index: true
      t.string :points

      t.timestamps null: false
    end
  end
end
