# frozen_string_literal: true

class Restaurant < ApplicationRecord
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy

  # 欄位認證
  validates :name, :address, presence: true
  mount_uploader :image, ImageUploader
  MAX_PRICE = 99_999_999_999_999
  SECTION_OPTIONS = %w[台北市 新北市]
  CUISINE_OPTIONS = ['中式料理', '日式料理', '亞洲料理', '健康料理', '印度料理', '台灣小吃/台菜', '壽司', '墨西哥料理', '法式料理', '美式料理', '燒肉', '韓式料理',
                     '越南料理', '海鮮料理']
  ATMOSTPHERE = %w[浪漫 大自然 舒適休閒 安靜 熱鬧 歷史悠久 藝術氛圍]
  RESTAURANT_TYPE = %w[餐廳 酒吧及夜店 小吃 麵包糕點 咖啡和茶 甜點 特色食品市場]
  PRICE_RANGE = %w[~200 200~400 400~800 800~1500 1500~]

  def self.search(keyword)
    where('name LIKE :keyword OR address LIKE :keyword OR cuisine_types::text ILIKE ANY (ARRAY[:keywords]) OR atmostphere::text ILIKE ANY (ARRAY[:keywords])',
          keyword: "%#{keyword}%", keywords: ["%#{keyword}%"])
  end

  def self.filter(address, restaurant_type, cuisine_types, atmostphere, min_price, max_price)
    sql_query_condition = []

    sql_query_condition.push "address ~ '#{address.join('|')}'" if address.present?
    sql_query_condition.push "restaurant_type ~ '#{restaurant_type.join('|')}'" if restaurant_type.present?
    sql_query_condition.push "cuisine_types @> '{#{cuisine_types.join(',')}}'" if cuisine_types.present?
    sql_query_condition.push "atmostphere @> '{#{atmostphere.join(',')}}'" if atmostphere.present?

    price_conditions = []
    if min_price.present? || max_price.present?
      min_price.zip(max_price).each do |min, max|
        price_conditions.push "price BETWEEN #{min} AND #{max}"
      end
    end
    sql_query_condition.push "(#{price_conditions.join(' OR ')})" if price_conditions.present?
    where(sql_query_condition.join(' AND '))
  end

  paginates_per 9
  mount_uploaders :images, ImageUploader

  class << self
    def cuisine_list
      CUISINE_OPTIONS.map { |k| [k, k] }
    end

    def atmostphere_list
      ATMOSTPHERE.map { |k| [k, k] }
    end

    def restaurant_type_list
      RESTAURANT_TYPE.map { |k| [k, k] }
    end
  end
end
