# frozen_string_literal: true

class Site < ApplicationRecord
  validates :name, :tel, :address, presence: true

  def self.search(keyword)
    where('name LIKE ? OR address LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
  paginates_per 8
  mount_uploader :image, ImageUploader
end
