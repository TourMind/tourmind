# frozen_string_literal: true

class DashboardController < ApplicationController
  def users
    @pagy, @users = pagy(User.all.order(:id))
    @users = @users.search(params[:keyword]) if params[:keyword].present?

    @regular_count = User.where(diamond_grade: '一般會員').count
    @wd_count = User.where(diamond_grade: '白鑽會員').count
    @bd_count = User.where(diamond_grade: '藍鑽會員').count
    @rd_count = User.where(diamond_grade: '紅鑽會員').count
    @prices = Order.sum(:amount)
  end

  def sites; end

  def hotels; end

  def restaurants; end
end
