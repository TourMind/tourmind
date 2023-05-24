# frozen_string_literal: true

class PageController < ApplicationController
  before_action :authenticate_user!, only: [:pricing]
  before_action :comment_all, :total_rating, :comment_rating, only: [:home]
  helper_method :star_rating
  def home; end

  def pricing
    @option_a = Newebpay::Mpg.new(50, current_user.id).form_info
    @option_b = Newebpay::Mpg.new(100, current_user.id).form_info
    @option_c = Newebpay::Mpg.new(200, current_user.id).form_info
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
  end

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
