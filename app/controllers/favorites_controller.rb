class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.order(updated_at: :desc)
  end

  def create
    favorite = current_user.favorites.new(favorite_params)
    return render json: { favorite_id: favorite.id } if favorite.save

    render json: { message: "新增失敗" }, status: :internal_server_error
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    head :no_content
  end

  private

  def favorite_params
    params.permit(:favorable_type, :favorable_id)
  end
end
