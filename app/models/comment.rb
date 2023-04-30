class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader
  scope :by_content, ->(content) { where("content LIKE ?", "%#{content}%") }
  validates :content, presence: true

  belongs_to :commentable, polymorphic: true
end
