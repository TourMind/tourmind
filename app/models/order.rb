# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  def self.diamond_grade(current_user)
    diamond_grade = if Order.where(user_id: current_user.id).last.amount === 50
                      '白鑽會員'
                    elsif Order.where(user_id: current_user.id).last.amount === 100
                      '藍鑽會員'
                    elsif Order.where(user_id: current_user.id).last.amount === 200
                      '紅鑽會員'
                    end
  end

  def self.expire_time(current_user)
    expire_time = Order.where(user_id: current_user.id).last.pay_time + 1.month
  end
end
