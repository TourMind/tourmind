class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader
  scope :by_content, ->(content) { where("content LIKE ?", "%#{content}%") }
  validates :content, presence: true
  def user_name
    User.find(user_id).name if user_id
  end
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
