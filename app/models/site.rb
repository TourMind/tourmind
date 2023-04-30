# frozen_string_literal: true

class Site < ApplicationRecord
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy

  validates :name, :tel, :address, presence: true
  mount_uploader :image, ImageUploader
  has_many :comments, as: :commentable, dependent: :destroy
  def self.search(keyword)
    where('name LIKE ? OR address LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
  paginates_per 8
end
