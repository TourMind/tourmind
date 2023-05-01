class Plan < ApplicationRecord
  validates :name, :description, presence: true

  def category_options
    %w[自然 文化 美食 冒險 休閒 浪漫 音樂 藝術]
  end
end
