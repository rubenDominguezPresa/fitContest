class User < ActiveRecord::Base
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :user_name, presence: true, length: { minimum: 4, maximum: 12 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :tracks
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_and_belongs_to_many :challenges, dependent: :destroy

  has_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :rankings
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :conversations, :foreign_key => :sender_id
  
  def follow(user_id)  
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def follow_challenge(challenge_id)  
    following_relationships.create(following_id: user_id)
  end

  def unfollow_challenge(challenge_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def self.search(search)
    where("user_name LIKE ?", "%#{search}%") 
    #where("content LIKE ?", "%#{search}%")
  end
end
