class Track < ActiveRecord::Base
	belongs_to :user
	belongs_to :challenge

	has_attached_file :image, styles: { :medium => "620x" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
