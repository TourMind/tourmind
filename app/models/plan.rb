# frozen_string_literal: true

class Plan < ApplicationRecord
  extend FriendlyId

  validates :name, :description, presence: true
  belongs_to :user

  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :collaborations, dependent: :destroy
  has_many :editors, through: :collaborations, source: :user

  mount_uploaders :images, ImageUploader
  friendly_id :name, use: :slugged

  def self.category_options
    %w[畢業 長青族 文化 美食 冒險 休閒 浪漫 音樂]
  end

  def self.set_color(type)
    return 'restaurant' if type == '餐廳'
    return 'hotel' if type == '住宿'
    return 'site' if type == '景點'
  end

  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end
end
