class CreateChallengesUsers < ActiveRecord::Migration
   def change
    create_table :challenges_users, id: false do |t|
      t.belongs_to :challenge, index: true
      t.belongs_to :user, index: true
     end
    end
end
