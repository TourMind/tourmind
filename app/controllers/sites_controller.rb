# frozen_string_literal: true

class SitesController < ApplicationController
  include PageHelper
  before_action :set_site, only: %i[show edit update destroy]
  helper_method :star_rating
  before_action :site_rating, only: %i[index show]
  before_action :check_permission, only: %i[new edit]

  def index
    # @pagy, @site = pagy(Site.all.order(:id), items: 6)
    declare_params

    @pagy, @sites = if params[:keyword].present?
                      pagy(Site.search(params[:keyword]).order(updated_at: :desc), items: 6)
                    elsif @address.present? || @site_types.present? || @pet_friendly.present?
                      pagy(Site.filter(@address, @site_types, @pet_friendly).order(updated_at: :desc), items: 6)
                    else
                      pagy(Site.order(updated_at: :desc), items: 6)
                    end
    return if @sites.empty?
  end

  def new
    @site = Site.new
  end

  def create
    params = Image::ImageService.remove_image(site_params)

    @site = Site.new(params)
    if @site.save
      redirect_to dashboard_sites_path, notice: '景點新增成功'
    else
      render :new
    end
  end

  def show
    @google_api_key = Rails.application.credentials.google_api_key
    @comment = Comment.new
    @comments = @site.comments
    @pagy, @paginated_comments = pagy(@comments.order(:id), items: 5)
  end

  def edit; end

  def update
    params = Image::ImageService.remove_image(site_params)
    if @site.update(params)
      redirect_to site_path(@site), notice: '景點更新成功'
    else
      render :edit
    end
  end

  def destroy
    set_site
    @site.destroy
    redirect_to dashboard_sites_path, notice: '景點刪除成功'
  end

  private

  def set_site
    @site = Site.friendly.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:name, :website, :address, :image, :parking, :tel, :latitude, :longitude,
                                 :stay_duration, :intro, :pet_friendly, :images_cache, site_types: [], images: [], remove_images: [],)
  end

  def check_permission
    if current_user.nil? || current_user.role != 0
      redirect_to sites_path, alert: '權限不足！'
    end
  end

  def declare_params
    @address = params[:address] || []
    @site_types = params[:site_types] || []
    @pet_friendly = params[:pet_friendly] || []
  end
end
