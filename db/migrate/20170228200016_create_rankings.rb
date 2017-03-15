class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :user, index: true
      t.references :challenge, index: true

      t.timestamps null: false

      change_table :challenges do |t|
        t.belongs_to :ranking, index: true
      end
    end
  end
end
