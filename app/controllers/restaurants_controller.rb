# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]
  helper_method :star_rating
  before_action :comment_rating, only: %i[index show]

  # GET /restaurants or /restaurants.json
  def index
    @pagy, @restaurants = pagy(Restaurant.all.order(:id),items: 6)
    declare_params
    get_min_max_price

    @restaurants = if params[:keyword].present?
                     Restaurant.search(params[:keyword]).order(updated_at: :desc).page(params[:page])
                   elsif @address.present? || @restaurant_type.present? || @cuisine_types.present? || @atmostphere.present? || @price_range.present?
                     Restaurant.filter(@address, @restaurant_type, @cuisine_types, @atmostphere, @min_price, @max_price).order(updated_at: :desc).page(params[:page])
                   else
                     Restaurant.order(updated_at: :desc).page(params[:page])
                   end
    flash.now[:alert] = '沒有找到符合條件的餐廳' and return if @restaurants.empty?
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
    @google_api_key = Rails.application.credentials.GOOGLE_API_KEY
    @comment = Comment.new
    @comments = @restaurant.comments
  end

  # GET /restaurants/new
  def new
    if current_user.nil? || current_user.role != 0
      redirect_to sites_path, alert: '權限不足！'
    else
      @restaurant = Restaurant.new
    end
  end

  # GET /restaurants/1/edit
  def edit; end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      get_location
      redirect_to restaurants_path, notice: '餐廳新增成功'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    if @restaurant.update(restaurant_params)
      get_location
      redirect_to restaurant_url(@restaurant), notice: '餐廳更新成功'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy
    redirect_to restaurants_url, notice: '餐廳刪除成功'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.friendly.find(params[:id])
  end

  def get_location
    GeocoderSearchJob.perform_later(@restaurant)
  end

  def get_min_max_price
    return unless params[:price_range].present?

    selected_price_ranges = params[:price_range].map { |price_range| price_range.split('~') }
    selected_price_ranges.each do |min_price_str, max_price_str|
      @min_price << min_price_str.to_i
      @max_price << (max_price_str ? max_price_str.to_i : Restaurant::MAX_PRICE)
    end
  end

  def declare_params
    @address = params[:address] || []
    @restaurant_type = params[:restaurant_type] || []
    @cuisine_types = params[:cuisine_types] || []
    @atmostphere = params[:atmostphere] || []
    @price_range = params[:price_range] || []
    @min_price = []
    @max_price = []
  end

  # Only allow a list of trusted parameters through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :intro, :address, :lat, :long, :image, :email, :tel,
                                       :website, :restaurant_type, { cuisine_types: [] }, :price, { atmostphere: [] }, { images: [] }).tap do |whitelisted|
      whitelisted[:cuisine_types].reject!(&:empty?)
      whitelisted[:atmostphere].reject!(&:empty?)
    end
  end

  def star_rating(rating)
    stars = ''
    if rating.present?
      full_stars = rating.to_i
      half_stars = rating - full_stars >= 0.1 ? 1 : 0
      empty_stars = 5 - full_stars - half_stars
      full_stars.times { stars += '<i class="fas fa-star" style="color: #fbbf24;"></i>' }
      half_stars.times { stars += '<i class="fa-solid fa-star-half-stroke" style="color: #fbbf24;"></i>' }
      empty_stars.times { stars += '<i class="fa-regular fa-star" style="color: #a5a6a7;"></i>' }
    else
      5.times { stars += '<i class="fas fa-star" style="color: #d8d8d8;"></i>' }
    end
    stars.html_safe
  end

  def comment_rating
    @restaurant_data = {}
    Restaurant.all.each do |restaurant|
      @restaurant_data[restaurant.id] = {
        average_rating: restaurant.comments.average(:rating).to_f,
        comment_count: restaurant.comments.where.not(content: nil).count,
      }
    end
  end
end
