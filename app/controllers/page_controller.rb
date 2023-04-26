# frozen_string_literal: true

class PageController < ApplicationController
  before_action :authenticate_user!, only: [:pricing]
  skip_before_action :verify_authenticity_token, only: %i[return notify]

  def home; end

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
    payment = current_user.payments.new(amount: response.mpg_result['Amt'],
                                        pay_time: response.mpg_result['PayTime'],
                                        status: '付款成功')
    payment.save
    redirect_to pricing_paymentok_path
  end

  def paymentok
    user = current_user.update(diamond_grade: Payment.diamond_grade)

    @last_payment = Payment.last
    @diamond_grade = Payment.diamond_grade
    @expire_time = Payment.expire_time
  end
end
