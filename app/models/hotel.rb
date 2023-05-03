# frozen_string_literal: true

class Hotel < ApplicationRecord
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy

  validates :name, :tel, :address, presence: true
  mount_uploader :image, ImageUploader
  def self.search(keyword)
    where('name LIKE ? OR address LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
  paginates_per 4
end
