# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 以下為飯店新增11筆
Hotel.create!(
  [
    {
      name: '和苑三井花園飯店台北忠孝',
      website: 'https://www.gardenhotels.co.jp/taipei-zhongxiao/tw/',
      star_rating: '4星級飯店',
      address: '台北市大安區忠孝東路三段30號1樓',
      latitude: 25.04339013,
      longitude: 121.5344147,
      intro:
        'MGH Mitsui Garden Hotel Taipei Zhongxiao 位於台北，距離大安森林公园 1.7 公里，有觀光旅遊櫃台、全面禁菸客房、共用休息室、全館WiFi（免費）以及餐廳。這間 4 星級飯店提供 24 小時接待櫃檯和行李寄放服務。住客可以欣賞市景。',
      hotel_types: '飯店',
      tel: '(02)27811131',
      images: '',
      equipment: %w[無線網路(WIFI) 停車場/停車位 早餐服務 24小時櫃檯接待 行李存放 乾洗服務 健身中心],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '台北馥敦飯店復南館',
      website: 'http://www.taipeifullerton.com.tw/',
      star_rating: '4星級飯店',
      address: ' 台北市大安區復興南路二段41號',
      latitude: 25.03302242,
      longitude: 121.5438641,
      intro:
        '台北馥敦飯店．復南館於 2019 年 6 月全面翻新，位於敦南商務中心，距離捷運大安站步行 5 分鐘。飯店提供設備齊全的健身中心、2 間餐廳和免費網路。',
      hotel_types: '飯店',
      tel: '(02)27031234',
      images: '',
      equipment: %w[無線網路(WIFI) 停車場/停車位 早餐服務 24小時櫃檯接待 行李存放 乾洗服務],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '旅樂序精品旅館站前五館',
      website: 'https://www.taiwantravelmap.com/hotel/508-ch-index.html',
      star_rating: '3星級飯店',
      address: '台北市中正區重慶南路一段20號',
      latitude: 25.04759785,
      longitude: 121.5133625,
      intro:
        '旅樂序精品旅館站前五館距離西門町購物商圈 8 分鐘步行路程，距離總統府 10 分鐘步行路程，最近的機場是台北松山機場，搭乘捷運 6 站即可抵達。',
      hotel_types: '飯店',
      tel: '(02)23756777',
      images: '',
      equipment: %w[無線網路(WIFI) 停車場/停車位 早餐服務 24小時櫃檯接待 行李存放 乾洗服務],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '台北時代寓所',
      website: 'https://tapestry.hilton.com.cn/zh-hk/hotel/taibei/hotel-resonance-taipei-tsaupup/index.html',
      star_rating: '4星級飯店',
      address: '台北市中正區林森南路7號',
      latitude: 25.04413481,
      longitude: 121.5233377,
      intro:
        '臺北時代寓所」為希爾頓全球酒店集團旗下一員，已於2020年底開業，並為亞太地區第一家Tapestry Collection by HiltonTM品牌精選飯店。以富有巧思的設計與細節規劃、摩登現代的藝術空間，結合臺灣獨有濃厚人情味與待客之道的<上心服務，臺北時代寓所致力提供所有旅客難忘的美好時光。',
      hotel_types: '飯店',
      tel: '(02)77521888',
      images: '',
      equipment: %w[無線網路(WIFI) 停車場/停車位 早餐服務 24小時櫃檯接待 行李存放 乾洗服務 健身中心],
    },
  ],
)

Hotel.create!(
  [
    {
      name: 'chez taipei no5',
      website: 'https://tapestry.hilton.com.cn/zh-hk/hotel/taibei/hotel-resonance-taipei-tsaupup/index.html',
      star_rating: '4星級飯店',
      address: '台北市中正區延平南路160-5號',
      latitude: 25.03817096,
      longitude: 121.5083426,
      intro:
        '這間休閒民宿位在商店林立的熱鬧街道上，步行 5 分鐘可達華西街上的商家和小吃攤，步行 6 分鐘可達捷運西門站，距離中正紀念堂 2 公里。',
      hotel_types: '飯店',
      tel: '(02)23883067',
      images: '',
      equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '誠品行旅',
      website: 'https://www.eslitehotel.com/',
      star_rating: '4星級飯店',
      address: '台北市信義區菸廠路98號',
      latitude: 25.033059,
      longitude: 121.567941,
      intro:
        '養身在動，養心在靜。從容體驗優雅的藝文空間，內蘊雍容，款待身心。誠品行旅，一處對美好生活飽藏無限想像之所在。',
      hotel_types: '飯店',
      tel: '(02)66262888',
      images: '',
      equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務 會議室/會議設施 24小時櫃檯接待],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '德立莊酒店',
      website: 'https://www.midtownrichardson.com/zh-tw',
      star_rating: '4星級飯店',
      address: '台北市中正區秀山街4號',
      latitude: 25.04287943,
      longitude: 121.5094476,
      intro:
        '德立莊酒店位於台北，毗鄰捷運西門站，提供舒適的住宿環境。所有客房均提供免費 WiFi。 德立莊酒店緊鄰有各式各樣餐飲和娛樂選項的西門町購物商圈，距離台北車站為 1 站捷運車程，距離台北松山機場為 7 站捷運車程，距離二二八和平紀念公園和總統府步行皆為 7 分鐘。 每間客房均設有空調、50 吋平面電視、小冰箱和電熱水壺，並提供茶包。為了客人旅途的便利，也備有拖鞋。私人衛浴內配有浴缸或淋浴設施。',
      hotel_types: '飯店',
      tel: '(02)23757777',
      images: '',
      equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務 24小時櫃檯接待],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '福容大飯店台北一館',
      website: 'https://www.fullon-hotels.com.tw/tp/tw/',
      star_rating: '5星級飯店',
      address: '台北市大安區建國南路一段266號',
      latitude: 25.03680116,
      longitude: 121.5374049,
      intro:
        '福容大飯店台北一館位於建國南路，距離大安森林公園站僅 5 分鐘步行路程。此豪華 5 星級飯店設有室外游泳池、SPA 中心和房內免費網路。 客房空間寬敞，裝潢時尚並配備現代家具。客房設備齊全，均配有迷你吧和室內保險箱。房內衛浴設有浴缸。 台北福容大飯店設有設備齊全的健身中心。住客可以在 Lih Spa 享受各種按摩課程和美容護理。',
      hotel_types: '飯店',
      tel: '(02)27019266',
      images: '',
      equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務 24小時櫃檯接待],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '君品酒店',
      website: 'https://www.palaisdechinehotel.comm',
      star_rating: '5星級飯店',
      address: '台北市大同區承德路一段3號',
      latitude: 25.04921221,
      longitude: 121.5166856,
      intro:
        '君品酒店是一家奢華的 5 星級穆斯林友善飯店，距離台北轉運站步行 3 分鐘，提供時尚住宿、3 間餐飲場所和健身中心。飯店距離可供住客免費使用的游泳池僅數步之遙。 客房均享有寬敞裝潢，設有現代化家具、空調、茶／咖啡沖泡設備、高保真音響系統和 40 吋平面有線電視。 飯店設有設備齊全的健身中心、商務中心（附傳真和影印設施），並提供洗衣和乾洗服務。',
      hotel_types: '飯店',
      tel: '(02)21819999',
      images: '',
      equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務 24小時櫃檯接待 酒吧/餐廳],
    },
  ],
)
Hotel.create!(
  [
    {
      name: 'Home Hotel',
      website: 'https://homehotel.com.tw/xinyi/',
      star_rating: '5星級飯店',
      address: '台北市信義區松仁路90號',
      latitude: 25.03505558,
      longitude: 121.5678609,
      intro:
        'Home Hotel 距離知名的台北 101 僅有 2 分鐘步行路程，距離象山捷運站有 5 分鐘步行路程。住宿提供免費 WiFi 和裝飾簡約的客房。館內設有商務中心和健身房。',
      hotel_types: '飯店',
      tel: '(02)87890111',
      images: '',
      equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務 24小時櫃檯接待 酒吧/餐廳 健身中心],
    },
  ],
)

Hotel.create!(
  [
    {
      name: '金普頓大安酒店 Kimpton Da An',
      website: 'https://www.ihg.com/kimptonhotels/hotels/tw/zh/da-an-hotel-taipei/tpekm/hoteldetail',
      star_rating: '5星級飯店',
      address: '台北市大安區仁愛路四段27巷25號',
      latitude: 25.039853,
      longitude: 121.548017,
      intro:
        '金普頓大安酒店-台灣唯一獲選Wallpaper* 雜誌2019最佳城市酒店! 隱身於台北東區靜謐街巷內，金普頓大安酒店與購物中心和捷運站僅隔一個街區。獨特地理位置，攘往熙來人潮看似近在咫尺，卻猶如世外桃源般靜謐。各式迷人充滿詩意的人文咖啡館、個性精品店與文藝畫廊，散落酒店周圍。而擁有129間舒適客、套房的金普頓酒店，以精緻細膩的設計詮釋復古與白瓷的層疊美學，相映著透光的天井建築，每一個轉彎都透著設計師巧思，邀請大膽創新的世界旅遊家和在地設計師一同品味徘徊探索。而當步入位於12樓的摩登餐酒館，可瞧見風情萬種的亞熱帶陽光灑落在寬敞戶外露台，除了可放鬆品酩美酒佳餚外，令人醉心的台北城景與聳入天際的台北101盡收眼底，徹底讓賓客體驗與挖掘新舊台北魅力與脈動。',
      hotel_types: '飯店',
      tel: '(02)21737999',
      images: '',
      equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務 24小時櫃檯接待 酒吧/餐廳],
    },
  ],
)
