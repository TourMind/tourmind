# frozen_string_literal: true

class Hotel < ApplicationRecord
  validates :name, :tel, :address, presence: true

  def self.search(keyword)
    where('name LIKE ? OR address LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
  paginates_per 4
end
