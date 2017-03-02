class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :user, index: true
      t.references :challenge, index: true
      t.string :tittle
      t.string :info
      t.string :category

      t.timestamps null: false
    end
  end
end
