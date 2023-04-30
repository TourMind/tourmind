class Plan < ApplicationRecord
  validates :name, :description, presence: true
end
