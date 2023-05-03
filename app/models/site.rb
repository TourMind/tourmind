# frozen_string_literal: true

class Site < ApplicationRecord
  validates :name, :tel, :address, presence: true
  mount_uploader :image, ImageUploader
  def self.search(keyword)
    where('name LIKE ? OR address LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
  paginates_per 8
end
