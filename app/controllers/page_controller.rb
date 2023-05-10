# frozen_string_literal: true

class PageController < ApplicationController
  before_action :authenticate_user!, only: [:pricing]
  skip_before_action :verify_authenticity_token, only: %i[return notify]
  before_action :comment_all, :total_rating, :comment_rating, only: [:home]
  helper_method :star_rating
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

  private
    def comment_all
      @hotel = Hotel.first
      @hotels = Hotel.all
      @site = Site.first
      @sites = Site.all
      @restaurant = Restaurant.first
      @restaurants = Restaurant.all
      @plan = Plan.first
      @plans = Plan.all

  def comment_rating
    @restaurant_data = {}
    Restaurant.all.each do |restaurant|
      @restaurant_data[restaurant.id] = {
        average_rating: restaurant.comments.average(:rating).to_f,
        comment_count: restaurant.comments.where.not(content: nil).count,
      }
    end
    @site_data = {}
    Site.all.each do |site|
      @site_data[site.id] = {
        average_rating: site.comments.average(:rating).to_f,
        comment_count: site.comments.where.not(content: nil).count,
      }
    end
    @hotel_data = {}
    Hotel.all.each do |hotel|
      @hotel_data[hotel.id] = {
        average_rating: hotel.comments.average(:rating).to_f,
        comment_count: hotel.comments.where.not(content: nil).count,
      }
    end
  end

  def star_rating(rating)
    stars = ''
    if rating.present?
      full_stars = rating.to_i
      half_stars = rating - full_stars >= 0.5 ? 1 : 0
      empty_stars = 5 - full_stars - half_stars
      full_stars.times { stars += '<i class="fas fa-star" style="color: #fbbf24;"></i>' }
      half_stars.times { stars += '<i class="fa-solid fa-star-half-stroke" style="color: #fbbf24;"></i>' }
      empty_stars.times { stars += '<i class="fa-regular fa-star" style="color: #a5a6a7;"></i>' }
    else
      5.times { stars += '<i class="fas fa-star" style="color: #d8d8d8;"></i>' }
    end
    stars.html_safe
  end

  def total_rating
    @average_rating = Comment.average_rating
    @comment_count = Comment.where.not(content: nil).count
  end
end
