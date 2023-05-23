# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]
  helper_method :star_rating
  before_action :comment_rating, only: %i[index show]
  before_action :check_permission, only: %i[new edit]
  before_action :declare_params, only: %i[index]

  def index
    get_min_max_price

    @pagy, @restaurants = if params[:keyword].present?
                            pagy(Restaurant.search(params[:keyword]).order(updated_at: :desc), items: 6)
                          elsif @address.present? || @restaurant_type.present? || @cuisine_types.present? || @atmostphere.present? || @price_range.present?
                            pagy(Restaurant.filter(@address, @restaurant_type, @cuisine_types, @atmostphere, @min_price,
                                                   @max_price,).order(updated_at: :desc), items: 6,)
                          else
                            pagy(Restaurant.order(updated_at: :desc), items: 6)
                          end
    return if @restaurants.empty?
  end

  def show
    @google_api_key = Rails.application.credentials.google_api_key
    @comment = Comment.new
    @comments = @restaurant.comments
    @pagy, @paginated_comments = pagy(@comments.order(:id), items: 5)
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit; end

  def create
    params = Image::ImageService.remove_image(restaurant_params)
    @restaurant = Restaurant.new(params)
    if @restaurant.save
      redirect_to dashboard_restaurants_url, notice: '餐廳新增成功'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    params = Image::ImageService.remove_image(restaurant_params)
    if @restaurant.update(params)
      redirect_to restaurant_url(@restaurant), notice: '餐廳更新成功'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to dashboard_restaurants_url, notice: '餐廳刪除成功'
  end

  private

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

  def restaurant_params
    params.require(:restaurant).permit(:name, :intro, :address, :lat, :long, :image, :email, :tel,
                                       :website, :restaurant_type, { cuisine_types: [] }, :price, { atmostphere: [] }, { images: [] }, { remove_images: [] },).tap do |whitelisted|
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

  def check_permission
    if current_user.nil? || current_user.role != 0
      redirect_to sites_path, alert: '權限不足！'
    end
  end
end
