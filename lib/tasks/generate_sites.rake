require 'open-uri'
require 'nokogiri'
require 'json'

MAX_PAGES = 3

desc 'generate sites for test'
namespace :data do
    task :generate_sites => :environment do
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

            #{"建築人文":["歷史建築","特色街區"......],"自然風光":[......],......}
    
            links = doc.css('a.online-poi-item-card').select {|link| link['href']} 
            #https://hk.trip.com/travel-guide/attraction/taipei/maokong-gondola-10572530/ *10


            links.each do |link|
              
                url = link['href']
                html = URI.open(url).read
                doc = Nokogiri::HTML.parse(html)
                script_tags = doc.css('script').select { |script| script.text.match(/("poiName"|"address"|"latitude"|"longitude"|"phone"|"introduction"|"defaultUrl"|"tagName")/) }
    
                poi_data = script_tags.map do |script|
    
                    poi_name_match = script.text.match(/"poiName"\s*:\s*"([^"]+)"/)
                    address_match = script.text.match(/"address"\s*:\s*"([^"]+)"/)
                    latitude_match = script.text.match(/"latitude"\s*:\s*([^,]+)/)
                    longitude_match = script.text.match(/"longitude"\s*:\s*([^}]+)/)
                    phone_match = script.text.match(/"phone":\s*\["([^"]+)\"\]/)
                    introduction_match = script.text.match(/"introduction":\s*"([^"]+)"/)
                    defaultUrl_match = script.text.match(/"defaultUrl":\s*"([^"]+)"/)
                    tagName_match = script.text.match(/"tagName":\s*"([^"]+)"/)
                    
                    
                    if poi_name_match && address_match && latitude_match && longitude_match && phone_match && introduction_match && defaultUrl_match && tagName_match
                    {
                        poiName: poi_name_match[1],
                        address: address_match[1],
                        latitude: latitude_match[1],
                        longitude: longitude_match[1],
                        phone: phone_match[1],
                        introduction: introduction_match[1].scan(/\p{Han}+/).join(''),
                        defaultUrl: defaultUrl_match[1],
                        tagName: tagName_match[1]
                    }
                    else
                        nil
                    end
                end.compact
                
                poi_data.each do |data|
                     #{"建築人文":["歷史建築","特色街區"......],"自然風光":[......],......}
                    site_type = []
                    result.each do |key, value|
                        if value.include?(data[:tagName])
                            site_type << key
                        end
                    end
    
                    site = Site.create(name: data[:poiName], 
                                       address: data[:address], 
                                       latitude: data[:latitude], 
                                       longitude: data[:longitude],
                                       tel: "09#{rand(10**8).to_s.rjust(8, '0')}",
                                       intro: data[:introduction],
                                       image: data[:defaultUrl],
                                       slug: data[:poiName],
                                       stay_duration: rand(1..9) * 0.5 + 0.5,
                                       site_types: site_type,
                                       website: 'https:www.google.com')
                    puts site
                end
            end
        end
    end 
end