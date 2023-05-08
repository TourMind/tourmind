class PlansController < ApplicationController
  before_action :find_plan,
                only: %i[show edit update destroy day_info plan_overview]
  before_action :authenticate_user!,
                except: %i[index show day_info plan_overview]
  before_action :find_favorites, only: %i[new edit]

  def index
    @plans = Plan.where(public: true).order(id: :desc)
  end

  def show
    return if (user_signed_in? && current_user == @plan.user) || @plan.public

    redirect_to plans_path, alert: '你沒有權限查看此行程！'
  end

  def new
    @plan = Plan.new
  end

  def create
    plan_data = plan_params
    plan_data[:locations] = update_locations(plan_data, nil)

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
    unless current_user == @plan.user
      @plan.name = ''
      @plan.description = ''
    end

    render :new
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
    if current_user == @plan.user && @plan.destroy
      return redirect_to plans_path, notice: '刪除成功'
    end

    redirect_to plans_path, alert: '你不是這個行程的擁有者'
  end

  def day_info
    @day = params[:day].to_i

    render 'day_nav'
  end

  def plan_overview
    render '_plan_overview'
  end

  private

  def find_plan
    @plan = Plan.find(params[:id])
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
      images: [],
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
end
