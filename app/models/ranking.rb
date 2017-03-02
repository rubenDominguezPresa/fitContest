class Ranking < ActiveRecord::Base
  belongs_to :challenge
  has_many :users
  has_many :scores
end
