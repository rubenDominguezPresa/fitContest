class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :user, index: true
      t.references :challenge, index: true
      t.string :tittle
      t.date :date
      t.time :duration
      t.float :distance
      t.integer :quantity
      t.string :category
      t.string :comments

      t.timestamps null: false
    end
  end

  def self.up
    change_table :tracks do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :tracks, :image
  end
end
