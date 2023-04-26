# frozen_string_literal: true

module RestaurantsHelper

  # def favorite_icon(object, size: '')
  #   if current_user && current_user.favorites.restaurants.find_by(favorable_id: object.id)
  #     link_to favorite_path(current_user.favorites.restaurants.find_by(favorable_id: object.id)), method: :delete do
  #       content_tag(:span, '', class: "text-red-500 #{size}", '&#x2665;')
  #     end
  #   else
  #     link_to favorites_path(favorites: {favorable_type: object.class, favorable_id: object.id}), method: :post do
  #       content_tag(:span, '', class: "text-white #{size}", '&#x2665;')
  #     end
  #   end
  # end
end
