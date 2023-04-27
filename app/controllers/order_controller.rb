# frozen_string_literal: true

class OrderController < ApplicationController
  def index
    if current_user.nil?
      redirect_to root_path
    else
      @order = Order.where(user_id: current_user.id).order(created_at: :desc)
    end
  end
end
