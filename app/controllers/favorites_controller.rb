class FavoritesController < ApplicationController
  include ApplicationHelper
  def index
    @favorites = current_user.favorites
  end

  def create
    @favorite = current_user.favorites.new(favorite_params)
    
    if @favorite.save
      # @favorite.favorable_id
      p "---------------------------------------------------------------------------------"
      p "#{request.env['HTTP_REFERER']}##{@favorite.favorable_id}"
      p "---------------------------------------------------------------------------------"
      redirect_to "#{request.env['HTTP_REFERER']}##{@favorite.favorable_id}"
      # redirect_back fallback_location: root_path, notice: '新增到喜愛清單'
    else
      redirect_back fallback_location: root_path, alert: '收藏失敗'
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_back fallback_location: root_path, notice: '以從喜愛清單中移除'
  end

  private

  def favorite_params
    params.require(:favorites).permit(:favorable_type, :favorable_id)
  end
end
