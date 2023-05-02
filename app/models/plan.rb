class Plan < ApplicationRecord
  validates :name, :description, presence: true
  belongs_to :user

  mount_uploader :images, ImageUploader
  # mount_uploaders :images, ImageUploader

  def self.category_options
    %w[自然 文化 美食 冒險 休閒 浪漫 音樂 藝術]
  end
end
