# frozen_string_literal: true

require 'json'

desc 'generate plans for test'
namespace :data do
  task generate_plans: :environment do
    Plan.destroy_all

    categories = %w[畢業 長青族 文化 美食 冒險 休閒 浪漫 音樂]
    users = User.all

    100.times do
      #================================================================
      random_days = (1..7).to_a.sample
      # random_minutes = (20..60).step(5).to_a.sample

      site_names = Site.pluck(:name)
      hotel_names = Hotel.pluck(:name)
      restaurant_names = Restaurant.pluck(:name)

      sites = {}
      (1..random_days).each do |day|
        sites[:"day#{day}"] = []
        3.times do
          site_name = site_names.sample
          site = Site.find_by(name: site_name)
          sites[:"day#{day}"] << {
            name: site_name,
            stay_time: (20..60).step(5).to_a.sample,
            type: '景點',
            lat: site.latitude,
            lng: site.longitude,
          }
        end
        2.times do
          restaurant_name = restaurant_names.sample
          restaurant = Restaurant.find_by(name: restaurant_name)
          sites[:"day#{day}"] << {
            name: restaurant_name,
            stay_time: (20..60).step(5).to_a.sample,
            type: '餐廳',
            lat: restaurant.lat,
            lng: restaurant.long,
          }
        end
        hotel_name = hotel_names.sample
        hotel = Hotel.find_by(name: hotel_name)
        sites[:"day#{day}"] << {
          name: hotel_name,
          stay_time: (20..60).step(5).to_a.sample,
          type: '住宿',
          lat: hotel.latitude,
          lng: hotel.longitude,
        }
      end

      sites.each_value do |array|
        first_element = array.first
        last_element = array.last
        middle_elements = array[1..-2].shuffle
        array.replace([first_element] + middle_elements + [last_element])
      end

      #================================================================

      user = users.sample
      category = categories.sample

      name = ''
      description = ''

      case category
      when '冒險'
        name = '冒險探索之旅'
        description = '這個行程充滿刺激和冒險的活動。你將參加各種戶外運動，如滑水、攀岩、跳傘等，挑戰自己的極限。你還可以嘗試新的體驗，如潛水、衝浪或跳傘，讓你的旅程充滿刺激和回憶。'
      when '美食'
        name = '美食之旅'
        description = '美食之旅將帶你品嚐各種美味佳餚。你將探索當地的特色菜肴和傳統美食，品嚐各種口味和風味。無論是街頭小吃還是高級餐廳，你都能夠享受到美食的盛宴。'
      when '音樂'
        name = '音樂之旅'
        description = '音樂之旅將帶你沉浸在動人的音樂世界中。你將參觀音樂廳、音樂節或音樂表演場地，欣賞各種風格和類型的音樂表演。無論是古典音樂、流行音樂、爵士樂還是民族音樂，你都能夠享受到精彩的演出和音樂的魅力。除了觀賞表演，你還可以參加音樂工作坊或音樂活動，與音樂家互動，深入了解音樂的創作和演奏過程。讓音樂之旅豐富你的心靈，帶來美妙的'
      when '文化'
        name = '文化探索之旅'
        description = '文化探索之旅將帶你領略當地的文化遺產和歷史景點。你將參觀博物館、藝術展覽、古蹟和建築，了解當地的歷史和傳統。你還可以參與文化活動和工作坊，親身體驗當地的文化傳統。'
      when '畢業'
        name = '畢業之旅'
        description = '畢業旅行是許多學生期待已久的一個重要時刻，標誌著他們學業生涯的結束和新的開始。這個遊程旨在提供一個難忘的旅行體驗，讓畢業生們能夠放鬆、慶祝並創造美好回憶。遊程可能包括前往知名旅遊目的地、參觀文化景點、體驗當地美食和娛樂活動等。畢業旅行也是與同學和朋友共度最後一次難忘時光的機會。'
      when '浪漫'
        name = '浪漫之旅'
        description = '在這個浪漫之旅中，你將與伴侶一起享受甜蜜的時刻。漫步於迷人的景點，分享浪漫的晚餐，一起觀賞美麗的日落。無論是在沙灘上散步、在城市中漫遊還是在大自然中共度浪漫時光，這個行程將為你們營造難忘的浪漫體驗'
      when '長青族'
        name = '長青族之旅'
        description = '長輩出遊是一個重要的家庭活動，讓年長的家庭成員能夠享受旅行的樂趣並增進彼此之間的關係。這個遊程的目的是提供一個輕鬆和愉快的旅行體驗，考慮到長輩的需求和舒適度。遊程可能包括參觀風景名勝、文化遺址、自然公園，以及參與輕鬆的活動如漫遊市集、參加文化表演或享受美食之旅。重要的是確保行程安排合適並提供足夠的休息時間，以讓長輩們輕鬆愉快地度過旅程。'
      when '休閒'
        name = '休閒度假'
        description = '這個行程將帶你遠離喧囂，享受寧靜和放鬆。你可以選擇在美麗的海灘度過悠閒的時光，參加瑜伽或冥想課程，享受舒緩的按摩和水療，探索寧靜的自然景點，讓自己的身心得到徹底的放鬆和恢復'
      end

      num = rand(1..5)
      picsums = []

      num.times do
        num_img = rand(1..1000)
        picsum_url = "https://picsum.photos/300/200/?random=#{num_img}"
        picsums << picsum_url
      end

      Plan.create(
        category:,
        name:,
        description:,
        days: random_days,
        locations: sites,
        user_id: user.id,
        public: true,
        picsums:,
      )
    end
    p 'generate plans done'
  end
end
