require 'open-uri'
require 'nokogiri'
require 'json'
require 'uri'



desc 'generate restaurants for test'
namespace :data do
    task :generate_restaurants => :environment do
        MAX_PAGES = 2
        restaurant_arr = %w[餐廳 酒吧及夜店 小吃 麵包糕點 咖啡和茶 甜點 特色食品市場]
        cuisine_arr = ['中式料理', '日式料理', '亞洲料理', '健康料理', '印度料理', '台灣小吃/台菜', '壽司', '墨西哥料理', '法式料理', '美式料理', '燒肉', '韓式料理', '越南料理', '海鮮料理', '義式料理']
        atmostphere_arr =%w[浪漫 大自然 舒適休閒 安靜 熱鬧 歷史悠久 藝術氛圍]

        url_contry = 'https://hk.trip.com/travel-guide/taiwan-100076/cities/'
        html = URI.open(url_contry).read
        doc = Nokogiri::HTML.parse(html)

        a_tags = doc.css('a[title="台北"][href]')
        hrefs = a_tags.map { |a| a['href'] }

        hrefs[0] = hrefs[0].gsub("destination", "foods")


        for i in 1..MAX_PAGES do

            url_city = "https://hk.trip.com#{hrefs[0]}restaurants/#{i}"
            html = URI.open(url_city).read
            doc = Nokogiri::HTML.parse(html)
    
            script_tag = doc.xpath("//script[@id='__NEXT_DATA__']")
            script_content = script_tag.first.content
            data = JSON.parse(script_content)
   
            links = doc.css('.gl-restaurants-lists-item a')
            links.each do |link|
                url = link['href'].gsub(" ", "%20").gsub('ï', 'i').gsub('ë', 'e')
                html = URI.open(url).read
                doc = Nokogiri::HTML.parse(html)
                script_tag = doc.xpath("//script[@id='__NEXT_DATA__']")
                script_content = script_tag.first.content
                data = JSON.parse(script_content)

                poiData = data['props']['pageProps']['appData']['poiData']
                name = poiData['poiName']
                address = poiData['poiAddress']
                lat = poiData['gglat']
                long = poiData['gglon']
                tel = poiData['phones']
                price = poiData['price']
                poiImage = poiData['poiImage']
                images = poiData["poiImage"].select { |image| image["title"] == name }.map { |image| image["imageUrl"] }
            

                restaurants = Restaurant.create(name: name, 
                                   address: address, 
                                   lat: lat, 
                                   long: long,
                                   tel: tel[0],
                                   slug: name,
                                   website: 'https:www.google.com',
                                   price: price,
                                   scraped_photos: images,
                                   restaurant_type: restaurant_arr.sample,
                                   cuisine_types: cuisine_arr.sample(rand(1..3)),
                                   atmostphere: atmostphere_arr.sample(rand(1..3)))
                puts restaurants   
            end
        end      
    end 
end