class Challenge < ActiveRecord::Base

  #has_and_belongs_to_many :posts, dependent: :destroy
  #has_and_belongs_to_many :users, dependent: :destroy
  has_many :registrations
  has_and_belongs_to_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :tracks


  #belongs_to :user, dependent: :destroy
  belongs_to :ranking

  #validates :user_id, presence: true
  #validates :image, presence: true
  #validates :description, length: { minimum: 3, maximum: 300 }

  #has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  #has_many :followers, through: :follower_relationships, source: :follower


  has_attached_file :image, styles: { :medium => "620x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

def self.search(search)
  where("name LIKE ?", "%#{search}%") 
  where("description LIKE ?", "%#{search}%")
end

end
