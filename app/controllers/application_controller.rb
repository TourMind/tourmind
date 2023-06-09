# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Rails.application.routes.url_helpers
  helper_method :show_guide?
  # 設定語言為中文
  before_action :set_locale
  def set_locale
    I18n.locale = :zh
  end
  

  # 用在需要在先登入才能進行動作
  # 根據 URL 中包含的信息，判斷應該重定向到哪個第三方驗證頁面
  def authenticate_user
    return if current_user.present?

    if request.env['omniauth.origin'].include?('google')
      redirect_to user_google_oauth2_omniauth_authorize_path
    else request.env['omniauth.origin'].include?('facebook')
      redirect_to user_facebook_omniauth_authorize_path
    end
  end
  def show_guide?
    # 返回 true 表示顯示 guide，返回 false 表示不顯示
    [HotelsController, SitesController,RestaurantsController,FavoritesController,PlansController].include?(self.class)
  end
  # 404:沒有找到紀錄
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def membership_expiry_date
    Order.where(user_id: current_user.id).last.pay_time + 1.month
  end

  def format_date(date)
    date.in_time_zone('Taipei').strftime('%Y/%m/%d')
  end

  private

  def record_not_found
    render file: Rails.public_path.join('404.html'),
           layout: false,
           status: :not_found and return
  end
end
