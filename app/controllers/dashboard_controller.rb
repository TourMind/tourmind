class DashboardController < ApplicationController
  def users
    @users = User.all.order(:id)
    @users = @users.search(params[:keyword]) if params[:keyword].present?
  end

  def sites
  end

  def hotels
  end

  def restaurants
  end
end
