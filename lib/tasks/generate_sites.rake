require 'open-uri'
require 'nokogiri'
require 'json'



desc 'generate sites for test'
namespace :data do
    task :generate_sites => :environment do
        MAX_PAGES = 2
        url_contry = 'https://hk.trip.com/travel-guide/taiwan-100076/cities/'
        html = URI.open(url_contry).read
        doc = Nokogiri::HTML.parse(html)

        a_tags = doc.css('a[title="台北"][href]')
        hrefs = a_tags.map { |a| a['href'] }

        hrefs[0] = hrefs[0].gsub("destination", "attraction")

        for i in 1..MAX_PAGES do

            url_city = "https://hk.trip.com#{hrefs[0]}tourist-attractions/#{i}.html"
            html = URI.open(url_city).read
            doc = Nokogiri::HTML.parse(html)
    
            script_tag = doc.xpath("//script[@id='__NEXT_DATA__']")
            script_content = script_tag.first.content
            data = JSON.parse(script_content)
    
            hash = data['props']["pageProps"]['FilterInfo']['filters']['attractionTypeFilter']
            result = Hash.new { |h, k| h[k] = [] }
    
            hash.each do |detail|
              name = detail["name"]
              filter = detail["filterDetails"]
              filter.each do |detail_sub|
                text = detail_sub["text"]
                result[name] << text
              end
            end

            #https://hk.trip.com/travel-guide/attraction/taipei/maokong-gondola-10572530/ *10
            links = doc.css('a.online-poi-item-card').select {|link| link['href']}
            links.each do |link|
              
                url = link['href']
                html = URI.open(url).read
                doc = Nokogiri::HTML.parse(html)

                script_tag = doc.xpath("//script[@id='__NEXT_DATA__']")
                script_content = script_tag.first.content
                data = JSON.parse(script_content)
                basicInfo = data['props']['pageProps']['appData']['overviewData']['basicInfo']
                poiName = basicInfo['poiName']
                address = basicInfo['address']
                introduction = basicInfo['introduction']
                filtered_introduction = introduction.gsub(/<p class="inset-p">|<\/p>/, '')
                tagList = basicInfo['tagList']
                coordinate = basicInfo['coordinate']
                latitude = coordinate['latitude']
                longitude = coordinate['longitude']
                imageInfo = basicInfo = data['props']['pageProps']['appData']['overviewData']['imageInfo']
                poiImage = imageInfo['imageList']
                phone = basicInfo['telephone'] || 'N/A'
                
                 #{"建築人文":["歷史建築","特色街區"......],"自然風光":[......],......}
                site_type = []
                result.each do |key, value|
                    if (value & tagList).any?
                            site_type << key
                    end
                end

                site = Site.create(name: poiName, 
                                   address: address, 
                                   latitude: latitude, 
                                   longitude: longitude,
                                   tel: phone, 
                                   intro: filtered_introduction,
                                   scraped_photos: poiImage,
                                   slug: poiName,
                                   stay_duration: rand(1..9) * 0.5 + 0.5,
                                   site_types: site_type,
                                   website: 'https:www.google.com')
                puts site               
            end
        end
    end 
end