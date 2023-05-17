# frozen_string_literal: true

class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[show edit update destroy]
  helper_method :star_rating
  before_action :comment_rating, only: %i[index show]
  before_action :check_permission, only: %i[new edit]

  def index
    @pagy, @hotels = pagy(Hotel.all.order(:id), items: 6)
    declare_params
    @hotels = if params[:keyword].present?
                Hotel.search(params[:keyword]).order(updated_at: :desc).page(params[:page])
              elsif @address.present? || @hotel_types.present? || @equipment.present?
                Hotel.filter(@address, @hotel_types, @equipment).order(updated_at: :desc).page(params[:page])
              else
                Hotel.order(updated_at: :desc).page(params[:page])
              end
    flash.now[:alert] = '沒有找到符合條件的飯店' and return if @hotels.empty?
  end

  def new
    @hotel = Hotel.new
  end

  def create
    params = Image::ImageService.remove_image(hotel_params)

    @hotel = Hotel.new(params)

    if @hotel.save
      redirect_to hotels_path, notice: '飯店新增成功'
    else
      render :new
    end
  end

  def show
    @google_api_key = Rails.application.credentials.google_api_key
    @comment = Comment.new
    @comments = @hotel.comments
  end

  def edit; end

  def update
    params = Image::ImageService.remove_image(hotel_params)

    if @hotel.update(params)
      redirect_to hotel_path(@hotel), notice: '飯店更新成功'
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    redirect_to hotels_path, notice: '飯店刪除成功'
  end

  private

  def set_hotel
    @hotel = Hotel.friendly.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :website, :star_rating, :address, :tel, :latitude, :longitude, :intro, :image,
                                  :hotel_types, :images_cache, equipment: [], images: [], remove_images: [],)
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
    @hotel_data = {}
    Hotel.all.each do |hotel|
      @hotel_data[hotel.id] = {
        average_rating: hotel.comments.average(:rating).to_f,
        comment_count: hotel.comments.where.not(content: nil).count,
      }
    end
  end

  def check_permission
    if current_user.nil? || current_user.role != 0
      redirect_to sites_path, alert: '權限不足！'
    end
  end

  def declare_params
    @address = params[:address] || []
    @hotel_types = params[:hotel_types] || []
    @equipment = params[:equipment] || []
  end
end
