class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.belongs_to :challenges, index: true
      t.belongs_to :users, index: true
      #t.string :name
      #t.string :description
      #t.string :type
      #t.string :rules
      #t.string :timing
      t.timestamps :registration_date
    end
  end
end
