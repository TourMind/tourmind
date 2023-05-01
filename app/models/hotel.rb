# frozen_string_literal: true

class Hotel < ApplicationRecord
  validates :name, :address, presence: true
  validates :tel, allow_blank: true,
                  format: { with: /\A(\(\d{2}\)|\d{2})\d{8}\z/, message: '請輸入有效的電話號碼，格式(02)12345678或0912123123' }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: '請輸入有效的網址' }, if: lambda {
                                                                                                    website.present?
                                                                                                  }

  def self.search(keyword)
    where('name LIKE :keyword OR address LIKE :keyword OR hotel_types LIKE :keyword OR equipment::text ILIKE ANY (ARRAY[:keywords])',
          keyword: "%#{keyword}%", keywords: ["%#{keyword}%"],)
  end

  def self.filter(address, hotel_types, equipment)
    sql_query_condition = []

    sql_query_condition.push "address ~ '#{address.join('|')}'" if address.present?
    sql_query_condition.push "hotel_types ~ '#{hotel_types.join('|')}'" if hotel_types.present?
    sql_query_condition.push "equipment @> '{#{equipment.join(',')}}'" if equipment.present?

    where(sql_query_condition.join(' AND '))
  end

  paginates_per 6
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader
end
