# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders
  has_many :plans
  has_many :collaborations, dependent: :destroy
  has_many :shared_plans, through: :collaborations, source: :plan

  has_many :comments, dependent: :destroy
  mount_uploader :avatar, ImageUploader
  # 驗證必填欄位
  validates :email,
            presence: true,
            format: {
              with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/,
            }
  
  validates :password, presence: true, on: :create

  validates :tel, allow_blank: true,
                 format: { with: /\A(\(\d{2}\)|\d{2})\d{8}\z/, message: '請輸入有效的電話號碼，格式(02)12345678或0912123123' }

  # confirmable -> 確認mail認證
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: %i[google_oauth2 facebook]

  # 喜愛清單關聯性
  has_many :favorites, inverse_of: :user

  # 驗證確認密碼
  validates_confirmation_of :password

  # 第三方認證登入後，創建用戶資料庫
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      %w[google_oauth2 facebook].each do |_provider|
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.avatar_url = auth.info.image
        user.email = auth.info.email if %w[facebook google_oauth2].include?(auth.provider)
      end
    end
  end

  # 不需要用戶提供密碼, 第三方登入不需要輸入密碼
  def password_required?
    false
  end

  def self.search(keyword)
    where('name like ? OR tel LIKE ? OR email LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end

  def self.city_list
    [['請選擇城市'], ['台北市'], ['新北市'], ['宜蘭'], ['花蓮'], ['高雄'], ['台南'],
     ['台東'], ['新竹'], ['彰化'], ['嘉義'], ['南投'], ['屏東']]
  end

  def default_avatar
    '/assets/user_default_avatar-4d250da78bcf1e681853cae1acb1174c0dcf35a31321d507fc27adf6591b2059.png'
  end

  def plans_limit_number
    case diamond_grade
    when '一般會員'
      1
    when '白鑽會員'
      3
    when '藍鑽會員'
      5
    when '紅鑽會員'
      Float::INFINITY # 正無窮大
    end
  end
end
