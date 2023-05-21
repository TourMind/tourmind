module PageHelp
    def set_view_data
        @hotels = Hotel.all
        @sites = Site.all
        @restaurants = Restaurant.all
        @plans = Plan.all.sample(3) 
      end
    
      def comment_rating
        @restaurant_data = {}
        Restaurant.all.each do |restaurant|
          @restaurant_data[restaurant.id] = {
            average_rating: restaurant.comments.average(:rating).to_f,
            comment_count: restaurant.comments.where.not(content: nil).count
          }
        end
    
        @site_data = {}
        Site.all.each do |site|
          @site_data[site.id] = {
            average_rating: site.comments.average(:rating).to_f,
            comment_count: site.comments.where.not(content: nil).count
          }
        end
    
        @hotel_data = {}
        Hotel.all.each do |hotel|
          @hotel_data[hotel.id] = {
            average_rating: hotel.comments.average(:rating).to_f,
            comment_count: hotel.comments.where.not(content: nil).count
          }
        end
      end
    
      def star_rating(rating)
        stars = ''
    
        if rating.present?
          full_stars = rating.to_i
          half_stars = rating - full_stars >= 0.5 ? 1 : 0
          empty_stars = 5 - full_stars - half_stars
    
          full_stars.times { stars += '<i class="fas fa-star" style="color: #fbbf24;"></i>' }
          half_stars.times { stars += '<i class="fa-solid fa-star-half-stroke" style="color: #fbbf24;"></i>' }
          empty_stars.times { stars += '<i class="fa-regular fa-star" style="color: #a5a6a7;"></i>' }
        else
          5.times { stars += '<i class="fas fa-star" style="color: #d8d8d8;"></i>' }
        end
    
        stars.html_safe
      end
      
      def total_rating
        @average_rating = Comment.average_rating
        @comment_count = Comment.where.not(content: nil).count
      end
end