# frozen_string_literal: true

class PaymentsController < ApplicationController
  # 處理訂單的更新資訊
  def notify
    response = Newebpay::MpgResponse.new(params[:TradeInfo])
  end

  # 處理訂單成功或失敗的轉址
  def return
    response = Newebpay::MpgResponse.new(params[:TradeInfo])

    return unless response.success?

    id = response.mpg_result['MerchantOrderNo'].split('_').first
    user = User.find_by(id:)
    order = user.orders.new(amount: response.mpg_result['Amt'],
                            pay_time: response.mpg_result['PayTime'],
                            status: '付款成功')
    order.save
    redirect_to ok_payment_path
  end

  def ok
    @diamond_grade = Order.diamond_grade(current_user)
    current_user.update(diamond_grade: @diamond_grade)
    # 撈取user的最後一筆訂單
    @last_order = current_user.orders.last
    @expire_time = Order.expire_time(current_user)
  end
end
