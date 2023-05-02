class Plan < ApplicationRecord
  # 喜愛清單關聯
  has_many :favorites, as: :favorable, dependent: :destroy
end
