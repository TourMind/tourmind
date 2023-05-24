module PageHelper
    def set_view_data
        @hotels = Hotel.all
        @sites = Site.all
        @restaurants = Restaurant.all
        @plans = Plan.all.sample(3) 
    end

    def calculate_average_rating_and_comment_count(records)
        data = {}
        
        records.each do |record|
            data[record.id] = {
            average_rating: record.comments.average(:rating).to_f,
            comment_count: record.comments.where.not(content: nil).count
            }
        end
        
        data
    end

    def site_rating
        @site_data = calculate_average_rating_and_comment_count(Site.all)
    end

    def plan_rating
        @plan_data = calculate_average_rating_and_comment_count(Plan.all)
    end

    def hotel_rating
        @hotel_data = calculate_average_rating_and_comment_count(Hotel.all)
    end

    def restaurant_rating
        @restaurant_data = calculate_average_rating_and_comment_count(Restaurant.all)
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
    end