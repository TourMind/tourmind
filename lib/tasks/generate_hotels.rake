require 'open-uri'
require 'nokogiri'
require 'json'
require 'uri'

desc 'generate hotels for test'
namespace :data do
    task :generate_hotels => :environment do

        hotel_types_arr = %w[飯店 民宿 青年旅館 度假村 日租套房 奢華酒店]
        equipment_arr = %w[無線網路(WIFI) 停車場/停車位 早餐服務 酒吧/餐廳 會議室/會議設施 健身中心 可攜帶寵物 行李存放 乾洗服務 腳踏車租賃 24小時櫃檯接待]

        url_contry = 'https://tw.trip.com/toplist/hotellist/taipei-100001403036'
        html = URI.open(url_contry).read
        doc = Nokogiri::HTML.parse(html)

        script_tag = doc.at_css('script[type="application/ld+json"]')
        
        data = JSON.parse(script_tag)

        itemListElement = data['itemListElement']

        itemListElement.each do |element|
            items = element['item']
            url = items['url']
            
            html = URI.open(url).read
            doc = Nokogiri::HTML.parse(html)

            script_tag = doc.at_css('script[type="application/ld+json"]')
            data = JSON.parse(script_tag)

            name = data['name']
            address_hash = JSON.parse(data['address'])
            street_address = address_hash['streetAddress']
            intro = data['description']
            image = data['image']
            latitude = html.match(/"lat":"(.*?)"/)[1]
            longitude = html.match(/"lng":"(.*?)"/)[1]
            
            hotel = Hotel.create(name: name, 
                               address: street_address, 
                               latitude: latitude, 
                               longitude: longitude,
                               tel: Faker::PhoneNumber.cell_phone,
                               intro: intro,
                               scraped_photo: image,
                               slug: name,
                               website: 'https:www.google.com',
                               hotel_types: hotel_types_arr.sample,
                               equipment: equipment_arr.sample(rand(1..4)))
            puts hotel         
        end
    end 
end