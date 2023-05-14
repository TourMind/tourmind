# frozen_string_literal: true

class PageController < ApplicationController
  before_action :authenticate_user!, only: [:pricing]
  before_action :comment_all, :total_rating, :comment_rating, only: [:home]
  helper_method :star_rating
  def home
    @keyword = params[:keyword]
    if @keyword.present?
      # 用于存储所有符合搜索条件的结果的数组
      results = []
      results += Restaurant.where("name LIKE ?", "%#{@keyword}%")
      results += Hotel.where("name LIKE ?", "%#{@keyword}%")
      results += Site.where("name LIKE ?", "%#{@keyword}%")
  
      # 如果有符合条件的结果，则跳转到第一个结果的页面
      if results.present?
        if results.first.is_a?(Site)
          redirect_to sites_path(q: @keyword)
        elsif results.first.is_a?(Restaurant)
          redirect_to restaurants_path(q: @keyword)
        elsif results.first.is_a?(Hotel)
          redirect_to hotels_path(q: @keyword)
        end
        return
      end
    end
  end
  def search
    @query = params[:query]
    @restaurants = Restaurant.where("name LIKE ?", "%#{@query}%")
    @hotels = Hotel.where("name LIKE ?", "%#{@query}%")
    @sites = Site.where("name LIKE ?", "%#{@query}%")
  
    if @restaurants.present?
      render "restaurants/index", restaurants: @restaurants, query: @query
    elsif @hotels.present?
      render "hotels/index", hotels: @hotels, query: @query
    elsif @sites.present?
      render "sites/index", sites: @sites, query: @query
    else
      # 如果没有搜索到符合条件的数据，可以渲染一个空的结果页面，或者提示用户没有找到任何数据
      flash.now[:alert] = "No results found for your search."
      render "search_empty"
    end
  end   

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
