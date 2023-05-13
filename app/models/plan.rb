class Plan < ApplicationRecord
  extend FriendlyId

  validates :name, :description, presence: true
  belongs_to :user

  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :collaborations
  has_many :editors, through: :collaborations, source: :user

  mount_uploaders :images, ImageUploader
  friendly_id :name, use: :slugged

  def self.category_options
    %w[自然 文化 美食 冒險 休閒 浪漫 音樂 藝術]
  end

  def self.set_color(type)
    return "restaurant" if type == "餐廳"
    return "hotel" if type == "住宿"
    return "site" if type == "景點"
  end

  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def self.plans_limit_number(current_user)
    if current_user.diamond_grade == "一般會員"
      return 1
    elsif current_user.diamond_grade == "白鑽會員"
      return 3
    elsif current_user.diamond_grade == "藍鑽會員"
      return 5
    elsif current_user.diamond_grade == "紅鑽會員"
      return Float::INFINITY #正無窮大
    end
  end
end
