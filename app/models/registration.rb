class Registration < ActiveRecord::Base

  belongs_to :challenge, dependent: :destroy
  belongs_to :user, dependent: :destroy
  
end
