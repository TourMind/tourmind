# frozen_string_literal: true

class SitesController < ApplicationController
  before_action :set_site, only: %i[show edit update destroy]
  helper_method :star_rating
  before_action :comment_rating, only: %i[index show]

  def index
    @pagy, @site = pagy(Site.all.order(:id), items: 6)
    @city_options = %w[台北市 新北市]
    @site_type_options = %w[自然景觀 歷史文化遺產 美術館 科博館 公園休閒 購物中心 主題樂園 海邊 動物園 體育館 溫泉景點 觀光勝地]
    @pet_friendly_options = %w[可攜寵物]

    @address = params[:address] || []
    @site_types = params[:site_types] || []
    @pet_friendly = params[:pet_friendly] || []

    @sites = if params[:keyword].present?
               Site.search(params[:keyword]).order(updated_at: :desc).page(params[:page])
             elsif @address.present? || @site_types.present? || @pet_friendly.present?
               Site.filter(@address, @site_types, @pet_friendly).order(updated_at: :desc).page(params[:page])
             else
               Site.order(updated_at: :desc).page(params[:page])
             end
    flash.now[:alert] = '沒有找到符合條件的景點' and return if @sites.empty?
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to sites_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @site.comments
    @comments_score = @comments.average(:rating).try(:round, 1)
  end

  def edit; end

  def update
    if @site.update(site_params)
      redirect_to site_path(@site), notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    set_site
    @site.destroy
    redirect_to dashboard_sites_path, notice: '已刪除!'
  end

  private

  def set_site
    @site = Site.friendly.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:name, :website, :address, :image, :parking, :tel, :latitude, :longitude,
                                 :stay_duration, :intro, :pet_friendly, :remove_images, :images_cache, site_types: [], images: [],)
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
    @site_data = {}
    Site.all.each do |site|
      @site_data[site.id] = {
        average_rating: site.comments.average(:rating).to_f,
        comment_count: site.comments.where.not(content: nil).count,
      }
    end
  end
end
