# frozen_string_literal: true

class Site < ApplicationRecord
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  validates :name, :address, presence: true
  validates :tel, allow_blank: true,
                  format: { with: /\A(\(\d{2}\)|\d{2})\d{8}\z/, message: '請輸入有效的電話號碼，格式(02)12345678或0912123123' }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: '請輸入有效的網址' }, if: lambda {
                                                                                                    website.present?
                                                                                                  }

  def self.search(keyword)
    where('name LIKE :keyword OR address LIKE :keyword OR site_types::text ILIKE ANY (ARRAY[:keywords])',
          keyword: "%#{keyword}%", keywords: ["%#{keyword}%"],)
  end

  def self.filter(address, site_types, pet_friendly)
    sql_query_condition = []

    sql_query_condition.push "address ~ '#{address.join('|')}'" if address.present?
    sql_query_condition.push "site_types @> '{#{site_types.join(',')}}'" if site_types.present?
    sql_query_condition.push "pet_friendly ~ '#{pet_friendly.join('|')}'" if pet_friendly.present?

    where(sql_query_condition.join(' AND '))
  end
  paginates_per 6
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader
end
