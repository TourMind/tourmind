class PlansController < ApplicationController
  before_action :find_plan,
                only: %i[show edit update destroy day_info plan_overview]
  before_action :authenticate_user!,
                except: %i[index show day_info plan_overview]
  before_action :find_favorites, only: %i[new edit]
  helper_method :star_rating
  before_action :comment_rating, only: %i[index show]
  def index
    @plans = Plan.where(public: true).order(id: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @plan.comments
    return if (user_signed_in? && current_user == @plan.user) || @plan.public

    redirect_to plans_path, alert: '你沒有權限查看此行程！'
  end

  def new
    if current_user.plans.count < Plan.plans_limit_number(current_user)
      @plan = Plan.new
    else
      flash[:alert] = "已達新增上限，請升級會員！"
      redirect_to plans_path
    end
  end

  def create
    plan_data = plan_params
    plan_data[:locations] = update_locations(plan_data, nil)
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
    if current_user.plans.count < Plan.plans_limit_number(current_user)
      unless current_user == @plan.user
        @plan.name = ''
        @plan.description = ''
      end

      render :new
    else
      flash[:alert] = "已達新增上限，請升級會員！"
      redirect_to plans_path
    end
  end

  def update
    plan_data = plan_params
    plan_data[:locations] = update_locations(plan_data, @plan)

    if current_user == @plan.user
      if @plan.update(plan_data)
        render json: { status: 'success', redirect_url: "/plans/#{@plan.id}" }
        return
      end

      render json: {
               errors: @plan.errors.full_messages,
             },
             status: :unprocessable_entity
      return
    end

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
    @day = params[:day].to_i

    render 'day_nav'
  end

  def plan_overview
    render '_plan_overview'
  end

  def check_user
    user = User.find_by(email: params[:email])

    if user != nil
      profile_pic =
        user.avatar_url ||
          '/assets/user_default_avatar-4d250da78bcf1e681853cae1acb1174c0dcf35a31321d507fc27adf6591b2059.png'
      user_name = user.name || '此使用者沒有設定姓名'

      render json: {
               status: 'success',
               profilePic: profile_pic,
               userName: user_name,
             }
      return
    end

    render json: { error: 'User not found' }, status: :unprocessable_entity
  end

  def add_editor
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
      images: []
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
          next(
            {
              name: restaurant.name,
              type: '餐廳',
              id: restaurant.id,
              stay_time: 0,
            }
          )
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
    @plan_data = {}
    Plan.all.each do |plan|
      @plan_data[plan.id] = {
        average_rating: plan.comments.average(:rating).to_f,
        comment_count: plan.comments.where.not(content: nil).count,
      }
    end
  end
end
