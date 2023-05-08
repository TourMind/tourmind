# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sites = {
  day1: [
    {
      name: '台北市立美術館',
      stay_time: 20,
      type: '景點',
      lat: 25.07261585329631,
      lng: 121.52475655161953,
    },
    {
      name: '華山1914文化創意產業園區',
      stay_time: 65,
      type: '景點',
      lat: 25.044244740152156,
      lng: 121.52932610929034,
    },
    {
      name: '饒河街觀光夜市',
      stay_time: 100,
      type: '餐廳',
      lat: 25.05108758917027,
      lng: 121.57745638045473,
    },
  ],
  day2: [
    {
      name: '國立故宮博物院',
      stay_time: 10,
      type: '景點',
      lat: 25.102512574287264,
      lng: 121.54849837133887,
    },
    {
      name: '北投溫泉區',
      stay_time: 38,
      type: '景點',
      lat: 25.13671194396663,
      lng: 121.50716520347267,
    },
    {
      name: '台北101觀景台',
      stay_time: 73,
      type: '景點',
      lat: 25.034287433437417,
      lng: 121.5640104669617,
    },
  ],
}

sites2 = {
  day1: [
    {
      name: '國立故宮博物院',
      stay_time: 20,
      type: '景點',
      lat: 25.102512574287264,
      lng: 121.54849837133887,
    },
    {
      name: '臺北101',
      stay_time: 30,
      type: '夜景',
      lat: 25.034287433437417,
      lng: 121.5640104669617,
    },
  ],
  day2: [
    {
      name: '陽明山國家公園',
      stay_time: 20,
      type: '景點',
      lat: 25.194498590641256,
      lng: 121.56089338045958,
    },
    {
      name: '北投區溫泉博物館',
      stay_time: 25,
      type: '溫泉',
      lat: 25.13671194396663,
      lng: 121.50716520347267,
    },
    {
      name: '士林官邸',
      stay_time: 35,
      type: '景點',
      lat: 25.093396983931115,
      lng: 121.53232659816169,
    },
  ],
  day3: [
    {
      name: '象山',
      stay_time: 15,
      type: '戶外',
      lat: 25.02742219851901,
      lng: 121.57654284502128,
    },
    {
      name: '中正紀念堂',
      stay_time: 40,
      type: '景點',
      lat: 25.035774267485415,
      lng: 121.5202357215834,
    },
  ],
}

categories = %w[自然 文化 美食 冒險 休閒 浪漫 音樂 藝術]

10.times do
  Plan.create!(
    name: '臺北城市文化探險之旅',
    description:
      '這個兩天的行程將帶你遊覽臺北市的文化、美食、自然和現代化等多個方面。第一天，您將參觀台灣藝術家的作品，探索熱鬧的藝文場所，品嚐當地美食。第二天，您將欣賞中國古代文物和藝術品，放鬆身心，欣賞城市全景。這個行程適合喜歡城市探險和文化體驗的旅行者。',
    days: 2,
    locations: sites,
    user_id: 1,
    public: true,
    category: categories.sample,
  )

  Plan.create!(
    name: '臺北城市自然和現代化之旅',
    description:
      '這個三天的行程將帶你遊覽臺北市的文化、美食、自然和現代化等多個方面。第一天，您將欣賞中國古代藝術品、探索著名的夜市、欣賞現代化建築的壯觀。第二天，您將欣賞壯麗的自然風光、探索台灣溫泉的歷史和文化。',
    days: 3,
    locations: sites2,
    user_id: 1,
    public: true,
    category: categories.sample,
  )
end

# 以下是景點新增8處
Site.destroy_all
Site.create(
  name: '松山文創園區',
  website: 'https://www.songshanculturalpark.org/',
  address: '台北市信義區光復南路133號',
  latitude: 25.040023,
  longitude: 121.564805,
  stay_duration: 2,
  intro:
    '松山文創園區肩負帶動臺北市原創力、強化文創軟實力且提升城市競爭力之使命，並定位為「臺北市原創基地」。2011年正式對外開放後，松山文創園區成為臺灣重要的創意樞紐，更是國際性的文創聚落，民眾可在此平台參與藝術與原創，體驗無限創意。',
  pet_friendly: '可攜寵物',
  site_types: %w[購物中心 歷史文化遺產],
  tel: '(02)27651388',
  images: '',
  parking: '是',
)

Site.create(
  name: '象山步道',
  website: 'https://www.travel.taipei/zh-tw/attraction/details/185',
  address: '台北市信義區',
  latitude: 25.02547258,
  longitude: 121.5791934,
  stay_duration: 2,
  intro:
    '象山海拔183公尺，步道全長1450公尺，全程約需1小時40分。因外形似象頭而得名，位於臺北盆地東南方的信義區，與虎山地質相同主要由砂岩組成，因造山作用步道中可見黃褐色陡峭的岩壁與巨石，加上自然環境生物、鳥類種類繁多，使得整座山如同一座天然生態樂園般，成為民眾接近淺山、享受戶外綠林悠閒時光的好去處。',
  pet_friendly: '可攜寵物',
  site_types: %w[自然景觀 公園休閒 觀光勝地],
  tel: '',
  images: '',
  parking: '是',
)
Site.create(
  name: '紀州庵文學森林',
  website: 'https://kishuan.org.tw/#1_2',
  address: '台北市中正區同安街107號',
  latitude: 25.02163907,
  longitude: 121.5205554,
  stay_duration: 1,
  intro:
    '隱藏在市區中，搭捷運就能到的絕美IG景點-紀州庵文學森林，被綠地包圍古色古香的日式木造建築，不必長途跋涉，一秒到日本，輕鬆搭台北捷運來趟文學之旅吧！',
  pet_friendly: '禁止攜帶寵物',
  site_types: %w[歷史文化遺產 公園休閒],
  tel: '',
  images: '',
  parking: '是',
)

Site.create(
  name: '虎山親山步道(四獸山步道)',
  website: 'https://www.travel.taipei/zh-tw/attraction/details/184',
  address: '台北市信義區福德街251巷36號',
  latitude: 25.0321363,
  longitude: 121.5875029,
  stay_duration: 2,
  intro:
    '虎山為四獸山市民森林區內之淺山之一，連接區後南港山系構成臺北市東南側的屏障，海拔140公尺，地質屬海相地層之單面山地形，西高東低、視野遼闊，山頂設有一座日晷，可以觀日計時，步道由塊狀砂岩與頁岩交疊而成，因虎山溪流經，山澗型的生態環境同時也是孕育螢火蟲、小綠蛙及蕨類等多元生態的最佳地點，溪岸經整修鞏固及完善水土保持後，虎山溪沿線成為觀賞溼地生態的最佳去處，步道沿線並設置解說牌及路線指標，是郊山健行又可觀賞生態的好去處。',
  pet_friendly: '可攜寵物',
  site_types: %w[自然景觀 公園休閒 觀光勝地],
  tel: '',
  images: '',
  parking: '是',
)

Site.create(
  name: '華山1914文創園區',
  website: 'https://www.huashan1914.com/w/huashan1914/index',
  address: '台北市中正區八德路一段1號',
  latitude: 25.04407505,
  longitude: 121.5293556,
  stay_duration: 2,
  intro:
    '華山1914文化創意產業園區前身是台北酒廠，由日本人於1914年創建，早期是日本生產清酒的廠房，後為台北酒廠，現為臺北市市定古蹟之一。',
  pet_friendly: '可攜寵物',
  site_types: %w[購物中心 歷史文化遺產],
  tel: '(02)23581914',
  images: '',
  parking: '是',
)

Site.create(
  name: '臺北市立動物園',
  website: 'https://www.zoo.gov.taipei/Content_List.aspx?n=F281704974533FFB',
  address: '台北市文山區新光路二段30號',
  latitude: 24.99855224,
  longitude: 121.5809945,
  stay_duration: 4,
  intro:
    '臺北市立動物園是東南亞規模最大的動物園，動物種類相當豐富與多樣，一整天也逛不完！出發前不妨先瀏覽官網的園區地圖、建議行程，挑選自己的專屬路線後，就能盡情享受可愛動物們的萌樣囉！',
  pet_friendly: '可攜寵物',
  site_types: %w[動物園],
  tel: '(02)29382300',
  images: '',
  parking: '是',
)

Site.create(
  name: '四四南村',
  website: 'https://www.travel.taipei/zh-tw/attraction/details/45',
  address: '台北市信義區松勤街50號',
  latitude: 25.031161,
  longitude: 121.56179,
  stay_duration: 1,
  intro:
    '早年為眷村，由於住戶均為聯勤第四十四兵工廠的廠工，因而得名「四四南村」。隨著社會變遷，眷村拆除改建成文教特區，並保留部份舊有的連棟式平房，讓人得以穿梭在小徑裡，遙想過去的眷村時光。裡面部分房舍改建為信義公民會館，作為舉辦活動及展演的開放空間，以顯現眷村遺址。',
  pet_friendly: '可攜寵物',
  site_types: %w[歷史文化遺產 公園休閒],
  tel: '',
  images: '',
  parking: '是',
)

Site.create(
  name: '臺北植物園',
  website: 'https://tpbg.tfri.gov.tw/',
  address: '台北市中正區南海路53號',
  latitude: 25.031004,
  longitude: 121.50865,
  stay_duration: 3,
  intro:
    '植物園自1921年創設以來，就是很多臺北人記憶中一部份，閒時來此佇足小憩，不論夏天的荷花、冬日的落葉，都是許多人美好的回憶。植物園附屬於農委會林業試驗所。西元1921年1月22日，正式發佈林業試驗場本場基地為植物園。到1930年左右，園內已栽種1,120種植物，其中泰半為國外引進者，對於學術及自然科學之教育貢獻極大。然而在二次大戰期間，園區樹木枯損殆盡。二戰後，將園區重行整理，同時積極引進各式國外樹種栽植。至今，園區內之建築與植物種類已遠超過以往盛況，搜羅之植物多達千餘種。植物展示區現區分為17個分區，分別展示各類植物。全區水塘依展示目的植物種類和用途區分成9區，並引進世界重要水生植物，營建具多樣性種類的水生植物池。由於都會區內鮮少綠地，植物園區內自然成為遊客休憩踏青的場所，尤其東鄰歷史博物館、科學館、藝術館等文教機構，構成都會區內著名的南海學園。',
  pet_friendly: '禁止攜帶寵物',
  site_types: %w[自然景觀 歷史文化遺產 公園休閒],
  tel: '(02)23039978',
  images: '',
  parking: '是',
)
Site.create(
  name: '貓空纜車',
  website: 'https://www.gondola.taipei/',
  address: '台北市文山區新光路二段8號',
  latitude: 24.99657249,
  longitude: 121.576633,
  stay_duration: 2,
  intro:
    '貓空纜車位於臺灣臺北市文山區於2007年7月4日啟用的架空索道，由臺北捷運公司負責營運。路線從臺北市立動物園西南側起，至貓空地區，全長4.03公里，共設有4站提供上下車服務。貓空纜車為台北市首座觀光休憩纜車，同時亦是臺灣最長、首座具有大眾運輸性質的纜車。',
  pet_friendly: '可攜寵物',
  site_types: %w[公園休閒 觀光勝地],
  tel: '',
  images: '',
  parking: '是',
)

Restaurant.destroy_all
Restaurant.create(
  name: '甘霖涼麵-永和店',
  intro:
    "我們是涼麵店，也有賣熱拌麵
    今天我想推薦給您 #純粹乾拌麵
    就是在這樣的天氣才會這樣的想起這碗麵
    使用純醬拌麵，沒有五光十色的過度調味
    淡黃色Q彈的麵條，完整吸附醬汁
    加上些許燙青菜
    入口後青菜的清脆與麵條的口感千絲萬縷
    輕鬆補充每日必須養分與熱量
    給您一碗單純的好味道
    滿足味覺...",
  address: '新北市永和區,得和路373巷,3號',
  tel: '0908032183',
  website: 'https://timely-noodle.business.site/',
  price: 120,
  restaurant_type: '台灣小吃/台菜',
  atmostphere: %w[舒適休閒],
  lat: 24.999679401438087,
  long: 121.52457507851321,
)

Restaurant.create(
  name: 'Osteria Rialto 雅朵義大利餐館',
  intro:
    '每次行經國父紀念館站看到『Osteria Rialto雅朵義大利餐館』店裡店外都是歐美臉孔，好像台北街頭看到的外國人都聚集在這了，而此情此景反射在我腦海的第一個念頭便是『Osteria Rialto雅朵義大利餐館』肯定口味道地，不然就是老闆主廚是外國人…，事後應證了我的直覺，沒錯，『Osteria Rialto雅朵義大利餐館』不論披薩、義大利麵以及各種開胃菜無一不精彩，而且主廚就是義大利人!!',
  address: '台北市大安區,光復南路260巷,5號',
  tel: '(02)27781536',
  website: 'https://www.facebook.com/osteriarialto/?locale=zh_TW',
  price: 800,
  restaurant_type: '餐廳',
  cuisine_types: %w[義式料理],
  atmostphere: %w[浪漫 舒適休閒],
  lat: 25.039967,
  long: 121.5541516,
)

Restaurant.create(
  name: '聰哥食堂 大安店',
  intro:
    "五十年前，一個來自於嘉義鄉下的孩子，靠自己的努力考上台大，
    畢業後成為跨國企業會計師，數十年的職場生活並未減少他對美食的熱情。
    身為家中長子的他從小就要幫忙燒飯，
    對料理產生濃厚的興趣，燒的一手好菜。
    他，就是創辦人—文聰哥
    退休後，文聰哥將自己私藏手路菜食譜集合起來，
    創辦「聰哥食堂」，將一道道的佳餚飄香入你我的日常。",
  address: '台北市大安區,復興南路二段,17號',
  tel: '(02)37076891',
  website: 'https://www.smartkitchen.tw/',
  price: 200,
  restaurant_type: '餐廳',
  cuisine_types: ['中式料理'],
  atmostphere: %w[安靜 舒適休閒],
  lat: 25.032374793862548,
  long: 121.54360533614681,
)

Restaurant.create(
  name: '小小樹食-敦南店',
  intro:
    '「小小樹食」強調真食物，堅持不使用加工品，食材來源必得講究。 在餐點中出現的少見生菜，如俄羅斯羽衣甘藍、京水菜、寶貝波菜、紅橡木萵苣、櫻桃蘿蔔；以及季節性的櫛瓜、櫛瓜花、墨西哥辣椒等，都出自自然農法耕作的農場。 呈現「新加州料理」，必備重要食材便是香甜肉厚的酪梨，但在台灣品質良好、如同滑順奶油般口感的酪梨多半仰賴進口。',
  address: '台北市大安區,敦化南路二段,39號',
  tel: '(02)27000313',
  website: 'https://www.facebook.com/LittleTreeFood/about?locale=zh_TW',
  price: 400,
  restaurant_type: '餐廳',
  cuisine_types: %w[健康料理 法式料理],
  atmostphere: %w[安靜 舒適休閒 藝術氛圍],
  lat: 25.0315979,
  long: 121.5492167,
)

Restaurant.create(
  name: 'CIN CIN OSTERIA 請請義大利餐廳',
  intro:
    '是一家蠻平價的義式餐廳，義大利麵和pizza約200多，對於店內的用料印象深刻，真材實料食材新鮮，是一家cp值很高的餐廳! 店內氣氛歡樂(大家的各種喧鬧聲)，是一個多人聚會的好選項',
  address: '台北市信義區,逸仙路50巷,22號',
  tel: '(02)27122050',
  website: 'https://www.facebook.com/cincinosteria/',
  price: 400,
  restaurant_type: '餐廳',
  cuisine_types: ['義式料理'],
  atmostphere: %w[熱鬧 舒適休閒],
  lat: 25.0405367,
  long: 121.5246863,
)

Restaurant.create(
  name: 'Gelovery Gift 法式甜點店',
  intro:
    '「Gelovery Gift 蒟若妮法式甜點店」，號稱「台北最美甜點」，還記得在東區開幕時可是引起一股熱絡的風潮，甚至還沒開始營業，門口都已經有客人在等候，當時看到它們家的甜點櫃時，妳真的會被驚豔到每款都想吃，但有些限量的早早就被搶光，有錢你還不見得吃的到！',
  address: '台北市大安區,大安路一段51巷,27號',
  tel: '(02)27317862',
  website: 'https://www.geloverygift.com/',
  price: 300,
  restaurant_type: '甜點',
  atmostphere: %w[安靜 舒適休閒],
  lat: 25.0418702,
  long: 121.5348735,
)

Restaurant.create(
  name: '泰市場 Spice Market',
  intro:
    '台北市唯一一家五星級泰式海鮮自助料理餐廳，豐美海鮮滿佈餐檯，泰式辛香料理引人食指大動，從開胃冷菜、熱炒、湯品、咖哩、沙爹到奶茶、冰淇淋和甜品糕點，帶給食客視覺與味覺的雙重美味饗宴。',
  address: '台北市信義區,松高路,11號',
  tel: '(02)87860029',
  website: 'https://www.regenttaiwan.com/dining/outside-dining/spice-market',
  price: 1200,
  restaurant_type: '餐廳',
  cuisine_types: %w[海鮮料理 泰式料理],
  atmostphere: %w[熱鬧],
  lat: 25.0395349,
  long: 121.5656192,
)

Restaurant.create(
  name: 'GYUU NIKU ステーキ專門店',
  intro:
    '來自日本的GYUU NIKU ステーキ專門店，特選Choice級牛排使用烤箱低溫烘烤的火山丼、酥脆黃金麵衣搭配菲力牛肉的炸牛排，搭配鮮甜濃郁的牛尾湯，給您不一樣的丼飯饗受！',
  address: '台北市信義區,忠孝東路五段,412號',
  tel: '(02)87800002',
  website: 'https://www.facebook.com/GYUUTW',
  price: 300,
  restaurant_type: '餐廳',
  cuisine_types: ['日式料理'],
  atmostphere: %w[熱鬧 舒適休閒],
  lat: 25.0404527,
  long: 121.5731091,
)

# 以下為飯店新增11筆
Hotel.destroy_all
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
Hotel.create(
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
)
