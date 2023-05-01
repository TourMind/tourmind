class DashboardController < ApplicationController
  def users
    @pagy, @users = pagy(User.all.order(:id))
    @users = @users.search(params[:keyword]) if params[:keyword].present?
  end

  def sites
  end

  def hotels
  end

  def restaurants
  end
end
