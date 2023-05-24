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
      'name LIKE :keyword OR address LIKE :keyword',
      keyword: "%#{keyword}%",
    ).or(
      where('site_types::text ILIKE ANY (ARRAY[:keywords])', keywords: ["%#{keyword}%"]),
    )
  end

  # 選項列表
  CITY_OPTIONS = %w[大同區 中正區 中山區 大安區 信義區 萬華區 士林區 瑞芳區 文山區 淡水區 萬里區 北投區]
  SITE_TYPE_OPTIONS = %w[建築人文 自然風光 展覽中心 宗教場所 公園/主題樂園 歷史遺跡 戶外運動 傳統文化體驗 觀光圈 生活休閒]
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
