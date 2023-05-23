# frozen_string_literal: true

class HotelsController < ApplicationController
  include PageHelper
  before_action :set_hotel, only: %i[show edit update destroy]
  helper_method :star_rating
  before_action :hotel_rating, only: %i[index show]
  before_action :check_permission, only: %i[new edit]

  def index
    # @pagy, @hotels = pagy(Hotel.all.order(:id), items: 6)
    declare_params
    @pagy, @hotels = if params[:keyword].present?
                       pagy(Hotel.search(params[:keyword]).order(updated_at: :desc), items: 6)
                     elsif @address.present? || @hotel_types.present? || @equipment.present?
                       pagy(Hotel.filter(@address, @hotel_types, @equipment).order(updated_at: :desc), items: 6)
                     else
                       pagy(Hotel.order(updated_at: :desc), items: 6)
                     end
    return if @hotels.empty?
  end

  def new
    @hotel = Hotel.new
  end

  def create
    params = Image::ImageService.remove_image(hotel_params)

    @hotel = Hotel.new(params)

    if @hotel.save
      redirect_to dashboard_hotels_path, notice: '住宿新增成功'
    else
      render :new
    end
  end

  def show
    @google_api_key = Rails.application.credentials.google_api_key
    @comment = Comment.new
    @comments = @hotel.comments
    @pagy, @paginated_comments = pagy(@comments.order(:id), items: 5)
  end

  def edit; end

  def update
    params = Image::ImageService.remove_image(hotel_params)

    if @hotel.update(params)
      redirect_to hotel_path(@hotel), notice: '住宿更新成功'
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    redirect_to dashboard_hotels_path, notice: '住宿刪除成功'
  end

  private

  def set_hotel
    @hotel = Hotel.friendly.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :website, :star_rating, :address, :tel, :latitude, :longitude, :intro, :image,
                                  :hotel_types, :images_cache, equipment: [], images: [], remove_images: [],)
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
