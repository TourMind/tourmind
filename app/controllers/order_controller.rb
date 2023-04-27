class OrderController < ApplicationController
  def index
    if current_user != nil
      @order = Order.where(user_id: current_user.id).order(created_at: :desc)
    else
      redirect_to root_path
    end
  end
end
