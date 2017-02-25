class Challenge < ActiveRecord::Base

  #has_and_belongs_to_many :posts, dependent: :destroy
  #has_and_belongs_to_many :users, dependent: :destroy
  has_many :registrations
  has_many :users, through: :registrations
  has_many :posts, dependent: :destroy


  belongs_to :user, dependent: :destroy

  #validates :user_id, presence: true
  validates :image, presence: true
  #validates :description, length: { minimum: 3, maximum: 300 }

  
  has_attached_file :image, styles: { :medium => "620x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
