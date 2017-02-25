class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.references :user, index: true
      #t.references :registrations, index: true
      t.string :name
      t.string :description
      t.string :type
      t.string :rules
      t.string :timing
      t.timestamps null: false

      change_table :posts do |t|
        t.belongs_to :challenge, index: true
      end
    end
    #add_reference :posts, :challenge, index: true
    #add_foreign_key :posts, :challenges
    #add_reference :challenges, :users
    #add_reference :users, :challenges
  end

  def self.up
    change_table :challenges do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :challenges, :image
  end
end
