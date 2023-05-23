# frozen_string_literal: true

class PlansController < ApplicationController
  include PageHelper
  before_action :find_plan,
                only: %i[show edit update destroy day_info plan_overview]
  before_action :authenticate_user!,
                except: %i[index show day_info plan_overview]
  before_action :find_favorites, only: %i[new edit]
  helper_method :star_rating
  before_action :plan_rating, only: %i[index show]
  def index
    @plans = Plan.where(public: true).order(id: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @plan.comments.order(created_at: :desc)
    @pagy, @paginated_comments = pagy(@comments.order(:id), items: 5)
    if (user_signed_in? && current_user == @plan.user) || @plan.public ||
       @plan.editors.include?(current_user)
      return
    end

    redirect_to plans_path, alert: '你沒有權限查看此行程！'
  end

  def new
    @plan = Plan.new
    if current_user.diamond_grade != '一般會員' && membership_expiry_date < format_date(Time.zone.now)
      current_user.update(diamond_grade: '一般會員')
      redirect_to pricing_path, alert: '會員已到期！'
    elsif current_user.plans.count >= current_user.plans_limit_number
      redirect_to plans_path, alert: '已達新增上限，請升級會員！'
    end
  end

  def create
    plan_data = plan_params
    plan_data[:locations] = update_locations(plan_data, nil)
    plan_data.delete(:lock_version)
    @commentable = @plan
    new_plan = current_user.plans.new(plan_data)

    if new_plan.save
      render json: { status: 'success', redirect_url: "/plans/#{new_plan.id}" }
      return
    end

    render json: {
             errors: new_plan.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def edit
    if current_user.plans.count >= current_user.plans_limit_number &&
       current_user != @plan.user && @plan.editors.exclude?(current_user)
      return redirect_to plans_path, alert: '已達新增上限，請升級會員！'
    end

    unless current_user == @plan.user || @plan.editors.include?(current_user)
      @plan.name = ''
      @plan.description = ''
    end

    render :new
  end

  def update
    plan_data = plan_params

    if current_user == @plan.user || @plan.editors.include?(current_user)
      begin
        plan_data[:locations] = update_locations(plan_data, @plan)

        if @plan.update(plan_data)
          render json: { status: 'success', redirect_url: "/plans/#{@plan.id}" }
          return
        end

        render json: {
                errors: @plan.errors.full_messages.map { |el| el.split(" ")[1] }.join("\n"),
              },
              status: :unprocessable_entity
        return
      
      rescue ActiveRecord::StaleObjectError, NoMethodError

        render json: {
                 errors: "行程已被共同編輯者更新，\n將在3秒後重新整理，\n以查看最新的內容。",
                 reload: 'true',
               },
               status: :unprocessable_entity
        return
      end
    end

    plan_data[:locations] = update_locations(plan_data, @plan)
    plan_data.delete(:lock_version)
    new_plan = current_user.plans.new(plan_data)

    if new_plan.save
      render json: { status: 'success', redirect_url: "/plans/#{new_plan.id}" }
      return
    end

    render json: {
             errors: new_plan.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def destroy
    return redirect_to plans_path, notice: '刪除成功' if current_user == @plan.user && @plan.destroy

    redirect_to plans_path, alert: '你不是這個行程的擁有者'
  end

  def day_info
    @google_api_key = Rails.application.credentials.google_api_key
    @day = params[:day].to_i

    render 'day_nav'
  end

  def plan_overview
    render '_plan_overview'
  end

  def check_user
    user = User.find_by(email: params[:email])

    unless user.nil?
      render json: {
        status: 'success',
        userId: user.id,
        profilePic: user.avatar_url || user.default_avatar,
        userName: user.name || '此使用者沒有設定姓名',
      }
      return
    end

    render json: { error: 'User not found' }, status: :unprocessable_entity
  end

  def add_editor
    plan = Plan.find(params[:id])
    user = User.find(params[:userId])

    return head status: :unauthorized if current_user != plan.user

    if current_user == user || plan.editors.include?(user)
      render json: {
               status: 'Failed',
               error: current_user == user ? '不能將自己加入共同編輯' : '該使用者已存在於共同編輯名單',
             },
             status: :unprocessable_entity
      return
    end

    plan.editors << user

    render json: {
      status: 'success',
      userId: user.id,
      profilePic: user.avatar_url || user.default_avatar,
      userName: user.name || '此使用者沒有設定姓名',
    }
  end

  def remove_editor
    plan = Plan.find(params[:id])
    user = User.find(params[:user_id])

    return head status: :unauthorized if current_user != plan.user

    plan.editors.destroy(user)
  end

  private

  def find_plan
    @plan = Plan.friendly.find(params[:id])
  end

  def plan_params
    params.permit(
      :name,
      :description,
      :days,
      :people,
      :public,
      :category,
      :locations,
      :lock_version,
      images: [],
      picsums: []
    )
  end

  def update_locations(data, reference)
    locations = JSON.parse(data[:locations])

    locations.each_key do |key|
      locations[key] = locations[key].map do |location|
        if location[0] == '餐廳'
          restaurant = Restaurant.find(location[1])
          output = {
            name: restaurant.name,
            type: '餐廳',
            lat: restaurant.lat,
            lng: restaurant.long,
            stay_time: location[2],
          }
          next output
        end

        if location[0] == '景點'
          site = Site.find(location[1])
          output = {
            name: site.name,
            type: '景點',
            lat: site.latitude,
            lng: site.longitude,
            stay_time: location[2],
          }
          next output
        end

        if location[0] == '住宿'
          hotel = Hotel.find(location[1])
          output = {
            name: hotel.name,
            type: '住宿',
            lat: hotel.latitude,
            lng: hotel.longitude,
            stay_time: location[2],
          }
          next output
        end

        output = reference[:locations][location[0]][location[1] - 1]
        output[:stay_time] = location[2]
        output
      end
    end
  end

  def find_favorites
    all_favorites = current_user.favorites.all

    @favorites =
      all_favorites.map do |fav|
        if fav.favorable_type == 'Restaurant'
          restaurant = Restaurant.find(fav.favorable_id)
          next({ name: restaurant.name, type: '餐廳', id: restaurant.id, stay_time: 0 })
        end

        if fav.favorable_type == 'Hotel'
          hotel = Hotel.find(fav.favorable_id)
          next({ name: hotel.name, type: '住宿', id: hotel.id, stay_time: 0 })
        end

        if fav.favorable_type == 'Site'
          site = Site.find(fav.favorable_id)
          next({ name: site.name, type: '景點', id: site.id, stay_time: 0 })
        end
      end
  end
end
