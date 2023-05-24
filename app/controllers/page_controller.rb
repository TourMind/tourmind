# frozen_string_literal: true

class PageController < ApplicationController
  include PageHelper
  before_action :authenticate_user!, only: [:pricing]
  skip_before_action :verify_authenticity_token, only: %i[return notify]
  before_action :set_view_data, :site_rating, :plan_rating,:hotel_rating,:restaurant_rating, only: [:home]
  helper_method :star_rating
  
  def home
  end
  def search
    @query = params[:query]
    @restaurants = Restaurant.where("name LIKE ?", "%#{@query}%")
    @hotels = Hotel.where("name LIKE ?", "%#{@query}%")
    @sites = Site.where("name LIKE ?", "%#{@query}%")
  end

  def pricing
    @option_a = Newebpay::Mpg.new(50, current_user.id).form_info
    @option_b = Newebpay::Mpg.new(100, current_user.id).form_info
    @option_c = Newebpay::Mpg.new(200, current_user.id).form_info
  end
end
