class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.order(updated_at: :desc)
  end

  def create
    favorite = current_user.favorites.new(favorite_params)
    return render json: { message: "新增到喜愛清單", favorite_id: favorite.id } if favorite.save

    render json: { message: "新增到喜愛清單" }
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_back fallback_location: root_path, notice: '已從喜愛清單中移除'
  end

  private

  def favorite_params
    params.permit(:favorable_type, :favorable_id)
  end
end
