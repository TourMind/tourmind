# frozen_string_literal: true

class DashboardController < ApplicationController
  def users
    if current_user.nil? || current_user.role != 0
      redirect_to hotels_path, alert: '權限不足！'
    else
      @pagy, @users = pagy(User.all.order(:id))
      @users = @users.search(params[:keyword]) if params[:keyword].present?

      @regular_count = User.where(diamond_grade: '一般會員').count
      @wd_count = User.where(diamond_grade: '白鑽會員').count
      @bd_count = User.where(diamond_grade: '藍鑽會員').count
      @rd_count = User.where(diamond_grade: '紅鑽會員').count
      @prices = Order.sum(:amount)
    end
  end

  def hotels
    @pagy, @hotels = pagy(Hotel.all.order(:id))
    @hotels = @hotels.search(params[:keyword]) if params[:keyword].present?
  end

  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy
    redirect_to dashboard_hotels_path
  end
end
