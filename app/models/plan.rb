class Plan < ApplicationRecord
  extend FriendlyId

  validates :name, :description, presence: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy
  mount_uploaders :images, ImageUploader

  def self.category_options
    %w[自然 文化 美食 冒險 休閒 浪漫 音樂 藝術]
  end

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end
end
