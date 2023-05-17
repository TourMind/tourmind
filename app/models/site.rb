# frozen_string_literal: true

class Site < ApplicationRecord
  extend FriendlyId
  # 分頁
  paginates_per 6
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy
  # 評論關聯
  has_many :comments, as: :commentable, dependent: :destroy

  # 欄位必填驗證
  validates :name, :address, presence: true
  # 格式驗證
  # validates :stay_duration,
  #          numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 24, message: '必須介於0.5至24小時之間' }, format: { with: /\A\d+(\.5|\.0)?\z/, message: '只能是整數或小數點後為 0 或 5 的數字' }
  # validates :tel, allow_blank: true,
  #                format: { with: /\A(\(\d{2}\)|\d{2})\d{8}\z/, message: '請輸入有效的電話號碼，格式(02)12345678或0912123123' }
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
  SITE_TYPE_OPTIONS = %w[自然景觀 歷史文化遺產 美術館 科博館 公園休閒 購物中心 主題樂園 海邊 動物園 體育館 溫泉景點 觀光勝地]
  PET_FRIENDLY_OPTIONS = %w[可攜寵物]

  # 篩選
  def self.filter(address, site_types, pet_friendly)
    sql_query_condition = []
    sql_query_condition << "address ~ '#{address.join('|')}'" if address.present?
    sql_query_condition << "site_types @> '{#{site_types.join(',')}}'" if site_types.present?
    sql_query_condition << "pet_friendly ~ '#{pet_friendly.join('|')}'" if pet_friendly.present?

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
