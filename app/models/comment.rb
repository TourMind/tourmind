class Comment < ApplicationRecord
  paginates_per 6
  scope :by_content, ->(content) { where('content LIKE ?', "%#{content}%") }
  validates :content, presence: true
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader

  def user_name
    User.find(user_id).name if user_id
  end

  def self.average_rating
    where.not(rating: nil).average(:rating) || 0
  end
end
