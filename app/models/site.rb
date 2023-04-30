# frozen_string_literal: true

class Site < ApplicationRecord
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  validates :name, :address, presence: true
  validates :tel, allow_blank: true, format: { with: /\A\(\d{2}\)\d{8}\z/, message: '請輸入有效的電話號碼，格式为(02)12345678' }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: '請輸入有效的網址' }, if: lambda {
                                                                                                    website.present?
                                                                                                  }

  def self.search(keyword)
    where('name LIKE :keyword OR address LIKE :keyword OR site_types::text ILIKE ANY (ARRAY[:keywords])',
          keyword: "%#{keyword}%", keywords: ["%#{keyword}%"],)
  end
  paginates_per 9
  mount_uploader :image, ImageUploader
end
