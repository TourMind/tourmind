# frozen_string_literal: true

class Hotel < ApplicationRecord
  extend FriendlyId
  # 分頁
  paginates_per 6
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy
  # 評論關聯
  has_many :comments, as: :commentable, dependent: :destroy
  # 欄位必填驗證以及格式驗證
  validates :name, :address, presence: true
  # validates :tel, presence: true,
  #                 format: { with: /\A(\(\d{2}\)|\d{2})\d{8}\z/, message: '請輸入有效的電話號碼，格式(02)12345678或0912123123' }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: '請輸入有效的網址' }, if: lambda {
                                                                                                    website.present?
                                                                                                  }
  # 關鍵字搜尋
  def self.search(keyword)
    where(
      'name LIKE :keyword OR address LIKE :keyword OR hotel_types LIKE :keyword',
      keyword: "%#{keyword}%",
    ).or(
      where('equipment::text ILIKE ANY (ARRAY[:keywords])', keywords: ["%#{keyword}%"]),
    )
  end

  # 選項列表
  CITY_OPTIONS = %w[台北市 新北市]
  HOTEL_TYPES_OPTIONS = %w[飯店 民宿 青年旅館 度假村 日租套房 奢華酒店]
  EQUIPMENT_OPTIONS = %w[無線網路(WIFI) 停車場/停車位 游泳池 早餐服務 酒吧/餐廳 會議室/會議設施 健身中心 可攜帶寵物 行李存放 乾洗服務 腳踏車租賃 24小時櫃檯接待]

  # 篩選
  def self.filter(address, hotel_types, equipment)
    sql_query_condition = []
    sql_query_condition << "address ~ '#{address.join('|')}'" if address.present?
    sql_query_condition << "hotel_types ~ '#{hotel_types.join('|')}'" if hotel_types.present?
    sql_query_condition << "equipment @> '{#{equipment.join(',')}}'" if equipment.present?

    where(sql_query_condition.join(' AND ')) unless sql_query_condition.empty?
  end

  # friendly_id
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  # 上傳圖片
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader
end
