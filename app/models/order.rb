# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  def self.diamond_grade(current_user)
    return if find_order(current_user).blank?

    case find_order(current_user).last.amount
    when 50
      '白鑽會員'
    when 100
      '藍鑽會員'
    when 200
      '紅鑽會員'
    else
      '一般會員'
    end
  end

  def self.expire_time(current_user)
    find_order(current_user)&.last&.pay_time&.+ 1.month
  end

  def self.find_order(current_user)
    Order.where(user_id: current_user.id)
  end
end
