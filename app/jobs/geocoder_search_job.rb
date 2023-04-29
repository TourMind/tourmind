# frozen_string_literal: true

class GeocoderSearchJob < ApplicationJob
  queue_as :default

  def perform(restaurant)
    location = Geocoder.search(restaurant.address).first.coordinates
    return if location.blank?

    restaurant.lat = location.first
    restaurant.long = location.last
    restaurant.save
  end
end
