class Favorite < ApplicationRecord
  belongs_to :user, inverse_of: :favorites
  belongs_to :favorable, polymorphic: true

  scope :hotels, -> { where(favorable_type: 'Hotel') }
  scope :restaurants, -> { where(favorable_type: 'Restaurant') }
  scope :sites, -> { where(favorable_type: 'Site') }
  scope :plans, -> { where(favorable_type: 'Plan') }

  validates :user_id, uniqueness: {
    scope: %i[favorable_id favorable_type],
    message: 'can only favorite an item once',
  }
end
