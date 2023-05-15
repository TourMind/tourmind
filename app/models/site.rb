# frozen_string_literal: true

class Site < ApplicationRecord
  extend FriendlyId
  paginates_per 6
  
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  # 停留時間驗證
  validates :stay_duration,
            numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 24, message: '必須介於0.5至24小時之間' }, format: { with: /\A\d+(\.5|\.0)?\z/, message: '只能是整數或小數點後為 0 或 5 的數字' }

  validates :name, :address, presence: true
  # validates :tel, allow_blank: true,
  #                 format: { with: /\A(\(\d{2}\)|\d{2})\d{8}\z/, message: '請輸入有效的電話號碼，格式(02)12345678或0912123123' }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: '請輸入有效的網址' }, if: lambda {
                                                                                                    website.present?
                                                                                                  }

  def self.search(keyword)
    where('name LIKE :keyword OR address LIKE :keyword OR site_types::text ILIKE ANY (ARRAY[:keywords])',
          keyword: "%#{keyword}%", keywords: ["%#{keyword}%"])
  end

  def self.filter(address, site_types, pet_friendly)
    sql_query_condition = []

    sql_query_condition.push "address ~ '#{address.join('|')}'" if address.present?
    sql_query_condition.push "site_types @> '{#{site_types.join(',')}}'" if site_types.present?
    sql_query_condition.push "pet_friendly ~ '#{pet_friendly.join('|')}'" if pet_friendly.present?

    where(sql_query_condition.join(' AND '))
  end

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader
end
