# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    if current_user.nil?
      redirect_to root_path, alert: '操作錯誤！請先登入會員！'
    else
      @order = Order.where(user_id: current_user.id).order(created_at: :desc)
    end
  end

  def show
    @order = Order.where(user_id: params[:id])
  end
end
