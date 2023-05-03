# frozen_string_literal: true

class Hotel < ApplicationRecord
  extend FriendlyId
  validates :name, :tel, :address, presence: true

  def self.search(keyword)
    where('name LIKE ? OR address LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
  paginates_per 4

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end
end
