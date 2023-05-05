# frozen_string_literal: true

class PageController < ApplicationController
  before_action :authenticate_user!, only: [:pricing]
  skip_before_action :verify_authenticity_token, only: %i[return notify]

  def home
  @hotel = Hotel.first
  @hotels = Hotel.all
  @site = Site.first
  @sites = Site.all
  @restaurant = Restaurant.first
  @restaurants = Restaurant.all
  end


  def pricing; end

  # 處理訂單的更新資訊
  def notify
    response = Newebpay::MpgResponse.new(params[:TradeInfo])
  end

  # 處理訂單成功或失敗的轉址
  def return
    response = Newebpay::MpgResponse.new(params[:TradeInfo])

    return unless response.success?

    current_user = User.find_by(id: response.mpg_result['MerchantOrderNo'].split('_')[0])
    order = current_user.orders.new(amount: response.mpg_result['Amt'],
                                    pay_time: response.mpg_result['PayTime'],
                                    status: '付款成功')
    order.save
    redirect_to pricing_paymentok_path
  end

  def paymentok
    user = current_user.update(diamond_grade: Order.diamond_grade(current_user))
    # 撈取user的最後一筆訂單
    @last_order = Order.where(user_id: current_user.id).last
    @diamond_grade = Order.diamond_grade(current_user)
    @expire_time = Order.expire_time(current_user)
  end
end
