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
      type: '景點',
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
      type: '景點',
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
      type: '景點',
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
      type: '景點',
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

categories = %w[文化]

Plan.destroy_all
Plan.create(
  [
    {
      name: '臺北城市文化探險之旅',
      description:
        '這個兩天的行程將帶你遊覽臺北市的文化、美食、自然和現代化等多個方面。第一天，您將參觀台灣藝術家的作品，探索熱鬧的藝文場所，品嚐當地美食。第二天，您將欣賞中國古代文物和藝術品，放鬆身心，欣賞城市全景。這個行程適合喜歡城市探險和文化體驗的旅行者。',
      days: 2,
      locations: sites,
      user_id: 1,
      public: true,
      category: categories.sample,
    },
    {
      name: '臺北城市自然和現代化之旅',
      description:
        '這個三天的行程將帶你遊覽臺北市的文化、美食、自然和現代化等多個方面。第一天，您將欣賞中國古代藝術品、探索著名的夜市、欣賞現代化建築的壯觀。第二天，您將欣賞壯麗的自然風光、探索台灣溫泉的歷史和文化。',
      days: 3,
      locations: sites2,
      user_id: 1,
      public: true,
      category: categories.sample,
    },
  ],
)

Restaurant.destroy_all
Restaurant.create(
  [
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
  ],
)

romantics = {
  day1: [
    {
      name: '華山1914文創園區',
      stay_time: 120,
      type: '景點',
      lat: 25.044273900525404,
      lng: 121.52937975366198,
    },
    {
      name: '彭巴草原炭火牛排館',
      stay_time: 90,
      type: '餐廳',
      lat: 25.046324917084686,
      lng: 121.53807705366222,
    },
    {
      name: 'DON DON DONKI 忠孝新生店',
      stay_time: 120,
      type: '景點',
      lat: 25.044601300545466,
      lng: 121.53228126715653,
    },
    {
      name: '台北時代寓所',
      stay_time: 960,
      type: '住宿',
      lat: 25.044134800757114,
      lng: 121.52335916900289,
    },
  ],
  day2: [
    {
      name: '阜杭豆漿',
      stay_time: 60,
      type: '餐廳',
      lat: 25.044478360551054,
      lng: 121.52473969599168,
    },
    {
      name: '臺灣文學基地(原齊東詩舍)',
      stay_time: 120,
      type: '景點',
      lat: 25.041339562842964,
      lng: 121.52842546530997,
    },
    {
      name: '光點華山電影館',
      stay_time: 120,
      type: '景點',
      lat: 25.045363638562183,
      lng: 121.52920201133236,
    },
    {
      name: '羊毛與花 ‧ 光點',
      stay_time: 120,
      type: '餐廳',
      lat: 25.053521962743954,
      lng: 121.52206443647496,
    },
  ],
}

categories = %w[浪漫]
Plan.create(
  name: '台北市中正區浪漫之旅',
  description:
    '這個浪漫之旅包含品嚐美食，體驗文化熱點如台灣文學基地和華山1914文創園區，觀賞標誌性的光華數位廣場電影，並在舒適的台北時代寓所享受夢幻住宿。一個完美的計劃，為尋求難忘浪漫之旅的情侶提供了理想的選擇。',
  days: 2,
  locations: romantics,
  user_id: 1,
  people: 2,
  public: true,
  category: categories.sample,
)
Site.destroy_all
Site.create(
  [
    {
      name: '華山1914文創園區',
      website: 'https://www.huashan1914.com/w/huashan1914/index',
      address: '台北市中正區八德路一段1號',
      latitude: 25.044273900525404,
      longitude: 121.52937975366198,
      stay_duration: 2,
      intro:
        '華山1914文化創意產業園區前身是台北酒廠，由日本人於1914年創建，早期是日本生產清酒的廠房，後為台北酒廠，現為臺北市市定古蹟之一。',
      pet_friendly: '可攜寵物',
      site_types: %w[購物中心 歷史文化遺產],
      tel: '(02)23581914',
      images: '',
      parking: '是',
    },
    {
      name: 'DON DON DONKI 忠孝新生店',
      website: 'https://www.dondondonki.com/tw/',
      address: '台北市中正區八德路一段55號B1',
      latitude: 25.044601300545466,
      longitude: 121.53228126715653,
      stay_duration: 2,
      intro:
    '高聳的地標性摩天大樓，設有商店、餐廳，以及位於 89 樓的觀景台。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[購物中心 觀光勝地],
      tel: '(02)23218911',
      images: '',
      parking: '是',
    },
    {
      name: '臺灣文學基地(原齊東詩舍)',
      website: 'https://www.breezecenter.com/',
      address: '台北市中正區濟南路二段27號',
      latitude: 25.041339562842964,
      longitude: 121.52842546530997,
      stay_duration: 1,
      intro:
        '統的日治時期風格建築，內有藝術品、展覽與活動空間。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[歷史文化遺產],
      tel: '(02)23279657',
      images: '',
      parking: '否',
    },
    {
      name: '光點華山電影館',
      website: 'http://www.spot-hs.org.tw/',
      address: '台北市中正區八德路一段1號',
      latitude: 25.045363638562183,
      longitude: 121.52920201133236,
      stay_duration: 2,
      intro:
    '在這裡，保存著過往的經典電影，讓人能回頭尋覓著過去的美好時刻。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[歷史文化遺產 電影院],
      tel: '(02)23940622',
      images: '',
      parking: '是',
    },
  ],
)
Restaurant.create(
  [
    {
      name: '彭巴草原炭火牛排館',
      intro:
        '選用新鮮食材料理、簡單香料做提味， 讓饕客們真正的品嚐到阿根廷在地料理。',
      address: '台北市中山區八德路二段168號',
      tel: '(02)27113478',
      website: 'http://www.lapampa.com.tw/',
      price: 1500,
      restaurant_type: '餐廳',
      cuisine_types: ['阿根廷料理'],
      atmostphere: %w[浪漫],
      lat: 25.046324917084686,
      long: 121.53807705366222,
    },
    {
      name: '阜杭豆漿',
      intro:
      '氣氛悠閒的餐廳，供應豆漿和燒餅等傳統早餐。',
      address: '台北市中正區忠孝東路一段108號2樓',
      tel: '(02)23922175',
      website: 'https://www.facebook.com/pages/%E8%8F%AF%E5%B1%B1%E5%B8%82%E5%A0%B4-%E9%98%9C%E6%9D%AD%E8%B1%86%E6%BC%BF/154088941341874',
      price: 200,
      restaurant_type: '小吃',
      atmostphere: %w[舒適休閒],
      lat: 25.044478360551054,
      long: 121.52473969599168,
    },
    {
      name: '羊毛與花 ‧ 光點',
      intro:
        '專賣傳統以色列料理的家常小店。',
      address: '台北市中山區中山北路二段18號',
      tel: '(02)25620099',
      website: 'https://www.facebook.com/youmoutoohanacoffeespot/menu',
      price: 600,
      restaurant_type: '餐廳',
      atmostphere: %w[舒適休閒 藝術氛圍],
      lat: 25.053521962743954,
      long: 121.52206443647496,
    },
  ],
)
Hotel.destroy_all
Hotel.create(
  name: '台北時代寓所',
  website: 'https://tapestry.hilton.com.cn/zh-hk/hotel/taibei/hotel-resonance-taipei-tsaupup/index.html',
  star_rating: '4星級飯店',
  address: '台北市中正區林森南路7號',
  latitude: 25.044134800757114,
  longitude: 121.52335916900289,
  intro:
    '臺北時代寓所」為希爾頓全球酒店集團旗下一員，已於2020年底開業，並為亞太地區第一家Tapestry Collection by HiltonTM品牌精選飯店。以富有巧思的設計與細節規劃、摩登現代的藝術空間，結合臺灣獨有濃厚人情味與待客之道的<上心服務，臺北時代寓所致力提供所有旅客難忘的美好時光。',
  hotel_types: '飯店',
  tel: '(02)77521888',
  images: '',
  equipment: %w[無線網路(WIFI) 停車場/停車位 早餐服務 24小時櫃檯接待 行李存放 乾洗服務 健身中心],
)

romantics2 = {
  day1: [
    {
      name: '台北101',
      stay_time: 60,
      type: '景點',
      lat: 25.03433603799665,
      lng: 121.56404265366179,
    },
    {
      name: '鼎泰豐 101店',
      stay_time: 90,
      type: '餐廳',
      lat: 25.03359607143909,
      lng: 121.564516282497,
    },
    {
      name: '象山步道',
      stay_time: 100,
      type: '景點',
      lat: 25.025423967015882,
      lng: 121.57925779599117,
    },
    {
      name: 'Grand Hyatt Taipei',
      stay_time: 960,
      type: '住宿',
      lat: 25.035384636167993,
      lng: 121.56292054016738,
    },
  ],
  day2: [
    {
      name: '四四南村',
      stay_time: 60,
      type: '景點',
      lat: 25.03165483294429,
      lng: 121.56185750366176,
    },
    {
      name: 'Miles.Q',
      stay_time: 90,
      type: '餐廳',
      lat: 25.03256977788403,
      lng: 121.560773282497,
    },
    {
      name: '微風南山',
      stay_time: 120,
      type: '景點',
      lat: 25.034527454027803,
      lng: 121.5661417536617,
    },
    {
      name: '波 WAVE Jaffa Cuisine Lab',
      stay_time: 120,
      type: '餐廳',
      lat: 25.031286564481782,
      lng: 121.56059062298017,
    },
  ],
}
categories = %w[浪漫]
Plan.create(
  name: '台北市信義區浪漫之旅',
  description:
    '這個浪漫之旅涵蓋了台北市內多個熱門景點、美食餐廳和高級飯店，讓您能夠盡情體驗台北的城市風情和美食文化。無論是登上台北101、遊覽象山、參觀四四南村，還是品嚐鼎泰豐和波 WAVE Jaffa Cuisine Lab的美食，您都能在這個行程中享受浪漫之旅的美好時刻。',
  days: 2,
  locations: romantics2,
  user_id: 1,
  people: 2,
  public: true,
  category: categories.sample,
)
Site.create(
  [
    {
      name: '象山步道',
      website: 'https://www.travel.taipei/zh-tw/attraction/details/185',
      address: '台北市信義區',
      latitude: 25.025423967015882,
      longitude: 121.57925779599117,
      stay_duration: 2,
      intro:
        '象山海拔183公尺，步道全長1450公尺，全程約需1小時40分。因外形似象頭而得名，位於臺北盆地東南方的信義區，與虎山地質相同主要由砂岩組成，因造山作用步道中可見黃褐色陡峭的岩壁與巨石，加上自然環境生物、鳥類種類繁多，使得整座山如同一座天然生態樂園般，成為民眾接近淺山、享受戶外綠林悠閒時光的好去處。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 公園休閒 觀光勝地],
      tel: '',
      images: '',
      parking: '是',
    },
    {
      name: '四四南村',
      website: 'https://www.travel.taipei/zh-tw/attraction/details/45',
      address: '台北市信義區松勤街50號',
      latitude: 25.03165483294429,
      longitude: 121.56185750366176,
      stay_duration: 1,
      intro:
        '早年為眷村，由於住戶均為聯勤第四十四兵工廠的廠工，因而得名「四四南村」。隨著社會變遷，眷村拆除改建成文教特區，並保留部份舊有的連棟式平房，讓人得以穿梭在小徑裡，遙想過去的眷村時光。裡面部分房舍改建為信義公民會館，作為舉辦活動及展演的開放空間，以顯現眷村遺址。',
      pet_friendly: '可攜寵物',
      site_types: %w[歷史文化遺產 公園休閒],
      tel: '',
      images: '',
      parking: '是',
    },
    {
      name: '台北101購物中心',
      website: 'https://www.taipei-101.com.tw/tw/',
      address: '台北市信義區市府路45號',
      latitude: 25.03433603799665,
      longitude: 121.56404265366179,
      stay_duration: 2,
      intro:
        '高聳的地標性摩天大樓，設有商店、餐廳，以及位於 89 樓的觀景台。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[購物中心 觀光勝地],
      tel: '(02)81018800',
      images: '',
      parking: '是',
    },
    {
      name: '微風南山',
      website: 'https://www.breezecenter.com/',
      address: '台北市信義區松智路17號',
      latitude: 25.034527454027803,
      longitude: 121.5661417536617,
      stay_duration: 2,
      intro:
        '當代風的購物中心，設有高級精品店、超市、餐廳和戶外座位區。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[購物中心 觀光勝地],
      tel: '(02)66389999',
      images: '',
      parking: '是',
    },
  ],
)
Restaurant.create(
  [
    {
      name: '鼎泰豐 101店',
      intro:
        '對美食的堅持，是對客人的一種責任，每一刻都是真正打動消費者的關鍵時刻，每一個細節都是累積鼎泰豐金字塔的砂礫，鼎泰豐的用心，可以讓每一個人嚐到安心。',
      address: '台北市信義區市府路45號B1',
      tel: '(02)81017799',
      website: 'https://www.dintaifung.com.tw/food.php',
      price: 400,
      restaurant_type: '餐廳',
      cuisine_types: ['台灣小吃/台菜'],
      atmostphere: %w[舒適休閒],
      lat: 25.033833,
      long: 121.564571,
    },
    {
      name: 'Miles.Q',
      intro:
        '因為喜歡吃甜甜，於是自己作甜甜',
      address: '台北市信義區信義路五段8巷11號1樓',
      tel: '(02)23458818',
      website: 'https://www.facebook.com/people/MilesQ/100063762854955/',
      price: 400,
      restaurant_type: '甜點',
      atmostphere: %w[安靜 舒適休閒],
      lat: 25.03256977788403,
      long: 121.560773282497,
    },
    {
      name: '波 WAVE Jaffa Cuisine Lab',
      intro:
        '專賣傳統以色列料理的家常小店。',
      address: '台北市信義區莊敬路178巷13號',
      tel: '(02)27223099',
      website: 'https://www.wavejaffa.com/',
      price: 600,
      restaurant_type: '餐廳',
      cuisine_types: ['以色列料理'],
      atmostphere: %w[安靜 舒適休閒 藝術氛圍],
      lat: 25.031286564481782,
      long: 121.56059062298017,
    },
  ],
)
Hotel.create(
  name: 'Grand Hyatt Taipei',
  website: 'https://www.hyatt.com/en-US/hotel/taiwan/grand-hyatt-taipei/taigh?src=corp_lclb_gmb_seo_taigh',
  star_rating: '5星級飯店',
  address: '台北市信義區松壽路2號',
  latitude: 25.035384636167993,
  longitude: 121.56292054016738,
  intro:
    '這間高檔飯店毗鄰台北 101 摩天大樓和觀景台，步行 8 分鐘可達台北國際會議中心。',
  hotel_types: '飯店',
  tel: '(02)27201234',
  images: '',
  equipment: %w[無線網路(WIFI) 停車場/停車位 早餐服務 酒吧/餐廳 行李存放 乾洗服務 24小時櫃檯接待 健身中心],
)
romantics3 = {
  day1: [
    {
      name: '大安森林公園',
      stay_time: 60,
      type: '景點',
      lat: 25.02984338198992,
      lng: 121.53632961133206,
    },
    {
      name: 'Le Blanc',
      stay_time: 90,
      type: '餐廳',
      lat: 25.036328909929853,
      lng: 121.54625064016749,
    },
    {
      name: 'Uspace Gallery',
      stay_time: 60,
      type: '景點',
      lat: 25.03587319371019,
      lng: 121.54835168249707,
    },
    {
      name: '永康商圈',
      stay_time: 120,
      type: '景點',
      lat: 25.03371019713954,
      lng: 121.53006886900269,
    },
    {
      name: 'Relay Juicetail Bar',
      stay_time: 120,
      type: '餐廳',
      lat: 25.032884414299026,
      lng: 121.5294899959914,
    },
    {
      name: '金普頓大安酒店',
      stay_time: 960,
      type: '住宿',
      lat: 25.04064870869355,
      lng: 121.54525199599156,
    },
  ],
  day2: [
    {
      name: '國父紀念館',
      stay_time: 120,
      type: '景點',
      lat: 25.040949663905426,
      lng: 121.56044396886206,
    },
    {
      name: '松山文創園區',
      stay_time: 120,
      type: '景點',
      lat: 25.043856829793715,
      lng: 121.56041637252713,
    },
    {
      name: '小小樹食-敦南店',
      stay_time: 120,
      type: '餐廳',
      lat: 25.031733973505833,
      lng: 121.54918450948571,
    },
  ],
}

categories = %w[浪漫]
Plan.create(
  name: '台北市大安區浪漫之旅',
  description:
    '這個浪漫之旅包含了台北市許多著名景點與美食餐廳，以及金普頓大安酒店提供的舒適住宿。行程包含了國父紀念館、松山文創園區、大安森林公園等知名景點，還有Relay Juicetail Bar、小小樹食等特色餐廳，讓您品嚐到道地的美食。這是一個精心設計的旅遊行程，讓您和您的伴侶度過難忘的浪漫時刻。',
  days: 2,
  locations: romantics3,
  user_id: 1,
  people: 2,
  public: true,
  category: categories.sample,
)
Site.create(
  [
    {
      name: '國父紀念館',
      website: 'https://www.yatsen.gov.tw/',
      address: '台北市信義區仁愛路四段505號',
      latitude: 25.040949663905426,
      longitude: 121.56044396886206,
      stay_duration: 2,
      intro:
        '國立國父紀念館是位於臺灣臺北市信義區的國家紀念建築，係紀念中華民國國父孫中山百年誕辰而興建的綜合性文化紀念設施，於1972年5月16日落成啟用，館區總面積達三萬五千坪。除了具紀念功能外，建築本體周圍是戶外運動、休閒、藝文與知性活動的綜合性休憩公園。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 公園休閒 觀光勝地],
      tel: '(02)27588008',
      images: '',
      parking: '是',
    },
    {
      name: '松山文創園區',
      website: 'https://www.songshanculturalpark.org/',
      address: '台北市信義區光復南路133號',
      latitude: 25.043856829793715,
      longitude: 121.56041637252713,
      stay_duration: 2,
      intro:
        '松山文創園區肩負帶動臺北市原創力、強化文創軟實力且提升城市競爭力之使命，並定位為「臺北市原創基地」。2011年正式對外開放後，松山文創園區成為臺灣重要的創意樞紐，更是國際性的文創聚落，民眾可在此平台參與藝術與原創，體驗無限創意。',
      pet_friendly: '可攜寵物',
      site_types: %w[購物中心 歷史文化遺產],
      tel: '(02)27651388',
      images: '',
      parking: '是',
    },
    {
      name: '永康商圈',
      website: 'https://www.taipeiyongkang.com.tw/index.html',
      address: '台北市大安區永康街',
      latitude: 25.03371019713954,
      longitude: 121.53006886900269,
      stay_duration: 2,
      intro:
        '永康商圈是位於臺灣臺北市大安區信義路二段上的著名商圈，大致為南北走向，介於金山南路與新生南路之間，北起信義路，南至和平東路，因巷弄之間有許多著名精緻行業而聞名。',
      pet_friendly: '可攜寵物',
      site_types: %w[觀光勝地],
      tel: '(02)23515793',
      images: '',
      parking: '是',
    },
    {
      name: 'Uspace Gallery',
      website: 'http://www.uspaceart.com/web/bbs/board.php?bo_table=work',
      address: '台北市大安區敦化南路1段312號',
      latitude: 25.03587319371019,
      longitude: 121.54835168249707,
      stay_duration: 2,
      intro:
        '-希望全台灣的每一個家庭都能擁有一件藝術品-
        創辦人20年前在日本畫廊被藝術品觸動，開始第一次收藏的心念，能記憶猶新。希望能站在首次收藏藝術藏家的角度，以同理心為藏家開啟新的一扇窗。能夠讓我們在台灣觸動更多新一代的朋友們。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[美術館],
      tel: '(02)27006883',
      images: '',
      parking: '否',
    },
    {
      name: '大安森林公園',
      website: 'https://www.travel.taipei/zh-tw/attraction/details/190',
      address: '台北市大安區新生南路二段1號',
      latitude: 25.02984338198992,
      longitude: 121.53632961133206,
      stay_duration: 2,
      intro:
        '公園位於台北市區中心，是一座草木濃密的生態公園，都會森林的型態被譽為台北市的「都市之肺」；其在興建之前被稱為「七號公園」，1994年3月29日正式對外開放，當時曾是台北市區最大的公園。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 公園休閒],
      tel: '(02)27003830',
      images: '',
      parking: '是',
    },
  ],
)
Restaurant.create(
  [
    {
      name: 'Le Blanc',
      intro:
          '明亮的餐酒館供應精選牛排和海鮮，並設有提供各種酒類的酒吧，店內洋溢歡樂氛圍。',
      address: '台北市大安區大安路一段183號',
      tel: '(02)27007770',
      website: 'https://www.facebook.com/leblanctaipei/',
      price: 1500,
      restaurant_type: '餐廳',
      cuisine_types: ['義式餐廳'],
      atmostphere: %w[浪漫 舒適休閒],
      lat: 25.036328909929853,
      long: 121.54625064016749,
    },
    {
      name: 'Relay Juicetail Bar',
      intro:
        '#最健康的酒吧/沒有化工糖漿和色素/只喝得到食材新鮮味/感受不到相對酒味的體驗/讓你享受喝舒服醉',
      address: '台北市大安區永康街6巷5號',
      tel: '(02)33221116',
      website: 'https://www.instagram.com/relay_juicetail/',
      price: 400,
      restaurant_type: '酒吧及夜店',
      atmostphere: %w[浪漫 舒適休閒],
      lat: 25.032884414299026,
      long: 121.5294899959914,
    },
    {
      name: '小小樹食-敦南店',
      intro:
    '「小小樹食」強調真食物，堅持不使用加工品，食材來源必得講究。 在餐點中出現的少見生菜，如俄羅斯羽衣甘藍、京水菜、寶貝波菜、紅橡木萵苣、櫻桃蘿蔔；以及季節性的櫛瓜、櫛瓜花、墨西哥辣椒等，都出自自然農法耕作的農場。 呈現「新加州料理」，必備重要食材便是香甜肉厚的酪梨，但在台灣品質良好、如同滑順奶油般口感的酪梨多半仰賴進口。',
      address: '台北市大安區敦化南路二段39號',
      tel: '(02)27000313',
      website: 'https://www.facebook.com/LittleTreeFood/about?locale=zh_TW',
      price: 600,
      restaurant_type: '餐廳',
      cuisine_types: %w[健康料理 法式料理],
      atmostphere: %w[安靜 舒適休閒 藝術氛圍],
      lat: 25.031733973505833,
      long: 121.54918450948571,
    },
  ],
)
Hotel.create(
  name: '金普頓大安酒店',
  website: 'https://www.ihg.com/kimptonhotels/hotels/tw/zh/da-an-hotel-taipei/tpekm/hoteldetail',
  star_rating: '5星級飯店',
  address: '台北市大安區仁愛路四段27巷25號',
  latitude: 25.04064870869355,
  longitude: 121.54525199599156,
  intro:
    '金普頓大安酒店-台灣唯一獲選Wallpaper* 雜誌2019最佳城市酒店! 隱身於台北東區靜謐街巷內，金普頓大安酒店與購物中心和捷運站僅隔一個街區。獨特地理位置，攘往熙來人潮看似近在咫尺，卻猶如世外桃源般靜謐。各式迷人充滿詩意的人文咖啡館、個性精品店與文藝畫廊，散落酒店周圍。而擁有129間舒適客、套房的金普頓酒店，以精緻細膩的設計詮釋復古與白瓷的層疊美學，相映著透光的天井建築，每一個轉彎都透著設計師巧思，邀請大膽創新的世界旅遊家和在地設計師一同品味徘徊探索。而當步入位於12樓的摩登餐酒館，可瞧見風情萬種的亞熱帶陽光灑落在寬敞戶外露台，除了可放鬆品酩美酒佳餚外，令人醉心的台北城景與聳入天際的台北101盡收眼底，徹底讓賓客體驗與挖掘新舊台北魅力與脈動。',
  hotel_types: '飯店',
  tel: '(02)21737999',
  images: '',
  equipment: %w[無線網路(WIFI) 早餐服務 行李存放 乾洗服務 24小時櫃檯接待 酒吧/餐廳],
)

romantics4 = {
  day1: [
    {
      name: '臺北市立美術館',
      stay_time: 120,
      type: '景點',
      lat: 25.07261585330351,
      lng: 121.52486384016827,
    },
    {
      name: 'CEO1950 總裁藝文空間',
      stay_time: 120,
      type: '餐廳',
      lat: 25.06589630923999,
      lng: 121.52653076715694,
    },
    {
      name: '林安泰古厝',
      stay_time: 120,
      type: '景點',
      lat: 25.072254743504836,
      lng: 121.5303594671572,
    },
    {
      name: '圓山東密道',
      stay_time: 120,
      type: '景點',
      lat: 25.07885853854636,
      lng: 121.52678802298145,
    },
    {
      name: '圓山大飯店-金龍餐廳',
      stay_time: 120,
      type: '餐廳',
      lat: 25.079373528811495,
      lng: 121.52683563647591,
    },
    {
      name: '圓山大飯店',
      stay_time: 960,
      type: '住宿',
      lat: 25.07900030106009,
      lng: 121.52652804073911,
    },
  ],
  day2: [
    {
      name: '劍潭山親山步道',
      stay_time: 120,
      type: '景點',
      lat: 25.079677213572246,
      lng: 121.5248767936583,
    },
    {
      name: '圓山育樂中心',
      stay_time: 120,
      type: '景點',
      lat: 25.08239774975404,
      lng: 121.52581431106438,
    },
    {
      name: '富樂臺式涮涮鍋',
      stay_time: 120,
      type: '餐廳',
      lat: 25.08213541751392,
      lng: 121.5234313094872,
    },
  ],
}

categories = %w[浪漫]
Plan.create(
  name: '台北市中山區浪漫之旅',
  description:
    '這個浪漫之旅涵蓋了台北市中山區和士林區多個景點和餐廳，並安排住宿。行程兩天，建議適合喜愛藝術、文化和自然風光的情侶參考',
  days: 2,
  locations: romantics4,
  user_id: 1,
  people: 2,
  public: true,
  category: categories.sample,
)
Site.create(
  [
    {
      name: '臺北市立美術館',
      website: 'https://www.tfam.museum/index.aspx?ddlLang=zh-tw',
      address: '台北市中山區中山北路三段181號',
      latitude: 25.07261585330351,
      longitude: 121.52486384016827,
      stay_duration: 2,
      intro:
        '臺北市立美術館，簡稱北美館，是位於臺灣臺北市圓山的公立美術館，成立於1983年12月24日，是臺灣第一座現當代美術館。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[美術館],
      tel: '(02)25957656',
      images: '',
      parking: '是',
    },
    {
      name: '林安泰古厝',
      website: 'https://linantai.taipei/',
      address: '台北市中山區濱江街5號',
      latitude: 25.072254743504836,
      longitude: 121.5303594671572,
      stay_duration: 2,
      intro:
    '於19世紀完工的古厝，現已改建為博物館，坐擁大型庭園。',
      pet_friendly: '可攜寵物',
      site_types: %w[歷史文化遺產],
      tel: '(02)25996026',
      images: '',
      parking: '否',
    },
    {
      name: '圓山育樂中心',
      website: 'https://www.facebook.com/pages/%E5%9C%93%E5%B1%B1%E4%BF%9D%E9%BD%A1%E7%90%83%E9%A4%A8/143509489046991',
      address: '台北市士林區中山北路五段6號',
      latitude: 25.08239774975404,
      longitude: 121.52581431106438,
      stay_duration: 2,
      intro:
        '擁有數十年歷史的樸實保齡球館，充滿懷舊氣氛，設有點心吧與兒童遊戲區。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[體育館],
      tel: '(02)28812277',
      images: '',
      parking: '是',
    },
    {
      name: '圓山東密道',
      website: 'https://www.grand-hotel.org/TW/official/attractions.aspx?gh=TP',
      address: '台北市中山區中山北路四段1號',
      latitude: 25.07885853854636,
      longitude: 121.52678802298145,
      stay_duration: 2,
      intro:
        '東密道全長67公尺，84階梯、43盞防爆燈，為當年提供元首的緊急逃生路線，不規則凹凸的牆面上設計特別，可減少回音干擾，密道迂迴彎曲的設計，也是為避開追兵和直線前進的子彈。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[歷史文化遺產 觀光勝地],
      tel: '(02)28868888',
      images: '',
      parking: '是',
    },
    {
      name: '劍潭山親山步道',
      website: '',
      address: '台北市中山區中山北路四段71巷2弄69號',
      latitude: 25.079677213572246,
      longitude: 121.5248767936583,
      stay_duration: 2,
      intro:
        '設有階梯和休息站的步道，可經由森林通往上坡的觀景台，欣賞一覽無遺的城市美景。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 公園休閒],
      tel: '(02)27593001',
      images: '',
      parking: '是',
    },
  ],
)
Restaurant.create(
  [
    {
      name: 'CEO1950 總裁藝文空間',
      intro:
          '明亮的餐酒館供應精選牛排和海鮮，並設有提供各種酒類的酒吧，店內洋溢歡樂氛圍。',
      address: '台北市中山區新生北路三段62巷24號',
      tel: '(02)25926692',
      website: 'https://www.facebook.com/CEO1950/',
      price: 1500,
      restaurant_type: '餐廳',
      cuisine_types: ['義式餐廳'],
      atmostphere: %w[浪漫 舒適休閒],
      lat: 25.06589630923999,
      long: 121.52653076715694,
    },
    {
      name: '圓山大飯店-金龍餐廳',
      intro:
        '門前的噴水池，金龍盤踞其中，訴說著百年的歷史，是金龍餐廳的精神代表。本餐廳供應廣東料理，中午有港式飲茶。主廚特別推薦：廣東點心、稻草西施牛肋骨、以及精采絕倫的御廚國宴。',
      address: '台北市中山區中山北路四段1號',
      tel: '(02)28868888',
      website: 'https://www.grand-hotel.org/TW/index.aspx',
      price: 1000,
      restaurant_type: '餐廳',
      cuisine_types: ['亞洲料理'],
      atmostphere: %w[歷史悠久],
      lat: 25.079373528811495,
      long: 121.52683563647591,
    },
    {
      name: '富樂臺式涮涮鍋',
      intro:
        '這間火鍋店在劍潭地區大約開店20年了，雖不是此地開最久的火鍋店，卻是最遠近馳名的火鍋店，記得之前店家將種植白甘蔗的盆栽擺在店門口，整排的白甘蔗小樹很吸睛，加上煮火鍋湯頭時散發的濃烈甘甜味，路過即不會錯過，而且非常平價。',
      address: '台北市士林區承德路四段75-1號',
      tel: '(02)28866895',
      website: '',
      price: 300,
      restaurant_type: '餐廳',
      cuisine_types: %w[亞洲料理],
      atmostphere: %w[安靜 舒適休閒 藝術氛圍],
      lat: 25.08213541751392,
      long: 121.5234313094872,
    },
  ],
)
Hotel.create(
  name: '圓山大飯店',
  website: 'https://www.grand-hotel.org/TW/index.aspx',
  star_rating: '5星級飯店',
  address: '台北市中山區中山北路四段1號',
  latitude: 25.07900030106009,
  longitude: 121.52652804073911,
  intro:
    '這間豪華飯店是一棟居高臨下的宮殿型建築，步行 12 分鐘可達台北市立美術館，距離台北 101 大樓 10 公里，步行 8 分鐘可達捷運劍潭站。',
  hotel_types: '飯店',
  tel: '(02)28868888',
  images: '',
  equipment: %w[無線網路(WIFI) 游泳池 健身中心 早餐服務 行李存放 乾洗服務 24小時櫃檯接待 酒吧/餐廳],
)

romantics5 = {
  day1: [
    {
      name: '祈堂老街',
      stay_time: 120,
      type: '景點',
      lat: 25.109682691469313,
      lng: 121.85873734016936,
    },
    {
      name: '迷迷路',
      stay_time: 120,
      type: '餐廳',
      lat: 25.109658436357027,
      lng: 121.85843303832306,
    },
    {
      name: '新北市立黃金博物館',
      stay_time: 120,
      type: '景點',
      lat: 25.106295018447568,
      lng: 121.85964006763453,
    },
    {
      name: '小洋樓民宿',
      stay_time: 960,
      type: '住宿',
      lat: 25.10995150148696,
      lng: 121.85804538249899,
    },
  ],
  day2: [
    {
      name: '九份老街',
      stay_time: 120,
      type: '景點',
      lat: 25.11078269858907,
      lng: 121.845268529152,
    },
    {
      name: '阿柑姨芋圓',
      stay_time: 30,
      type: '餐廳',
      lat: 25.10798293955323,
      lng: 121.84363926715822,
    },
    {
      name: '山城觀景台',
      stay_time: 60,
      type: '景點',
      lat: 25.10853997834049,
      lng: 121.84044223832308,
    },
    {
      name: '野事草店 Wild Herbs Gallery',
      stay_time: 120,
      type: '餐廳',
      lat: 25.10729103492388,
      lng: 121.84179505366367,
    },
  ],
}

categories = %w[浪漫]
Plan.create(
  name: '新北市瑞芳區浪漫之旅',
  description:
    '這個浪漫之旅包含了新北市瑞芳區多個知名景點、餐廳和住宿。第一天可以走祈堂老街、新北市立黃金博物館等景點，並在小洋樓民宿住宿。第二天則可以前往九份老街、山城觀景台等地，還有野事草店餐廳等美食可品嘗。這個行程適合情侶或浪漫旅行愛好者，讓您在浪漫的氛圍中度過美好的時光。',
  days: 2,
  locations: romantics5,
  user_id: 1,
  people: 2,
  public: true,
  category: categories.sample,
)
Site.create(
  [
    {
      name: '祈堂老街',
      website: 'https://newtaipei.travel/zh-tw/attractions/detail/110857',
      address: '新北市瑞芳區祈堂路',
      latitude: 25.109682691469313,
      longitude: 121.85873734016936,
      stay_duration: 2,
      intro:
        '位於昔日礦工住宅區的陡峭街道，可登上色彩鮮艷的階梯一覽美麗海景。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 歷史文化遺產 觀光勝地],
      tel: '(02)24962800',
      images: '',
      parking: '是',
    },
    {
      name: '新北市立黃金博物館',
      website: 'https://www.gep.ntpc.gov.tw/',
      address: '新北市瑞芳區金光路8號',
      latitude: 25.106295018447568,
      longitude: 121.85964006763453,
      stay_duration: 2,
      intro:
        '以金礦開採文化為主題的露天博物館，也是古老的裕仁太子賓館所在地。',
      pet_friendly: '禁止攜帶寵物',
      site_types: %w[歷史文化遺產],
      tel: '(02)24962800',
      images: '',
      parking: '否',
    },
    {
      name: '九份老街',
      website: 'https://newtaipei.travel/zh-tw/attractions/detail/109990',
      address: '新北市瑞芳區基山街',
      latitude: 25.11078269858907,
      longitude: 121.845268529152,
      stay_duration: 2,
      intro:
        '繁忙的地區，以狹窄的街道、各式美食攤位及遼闊的山海景緻聞名。',
      pet_friendly: '可攜寵物',
      site_types: %w[歷史文化遺產 觀光勝地],
      tel: '(02)24063270',
      images: '',
      parking: '是',
    },
    {
      name: '山城觀景台',
      website: '',
      address: '新北市瑞芳區',
      latitude: 25.10853997834049,
      longitude: 121.84044223832308,
      stay_duration: 1,
      intro:
        '視野好、安靜的觀景台，可以一覽九份山城。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 歷史文化遺產],
      tel: '',
      images: '',
      parking: '否',
    },
  ],
)
Restaurant.create(
  [
    {
      name: '迷迷路',
      intro:
        '來到九份的祈堂小巷，老式建築裡的小店，坐在窗邊，不知不覺一個下午就過去了。',
      address: '新北市瑞芳區祈堂路150號',
      tel: '(02)24961008',
      website: 'https://www.facebook.com/jinguashi/',
      price: 600,
      restaurant_type: '餐廳',
      cuisine_types: ['亞洲料理'],
      atmostphere: %w[浪漫 舒適休閒],
      lat: 25.109658436357027,
      long: 121.85843303832306,
    },
    {
      name: '阿柑姨芋圓',
      intro:
        '門前的噴水池，金龍盤踞其中，訴說著百年的歷史，是金龍餐廳的精神代表。本餐廳供應廣東料理，中午有港式飲茶。主廚特別推薦：廣東點心、稻草西施牛肋骨、以及精采絕倫的御廚國宴。',
      address: '新北市瑞芳區豎崎路5號',
      tel: '(02)24976505',
      website: 'https://m.facebook.com/pages/%E4%B9%9D%E4%BB%BD%E9%98%BF%E6%9F%91%E5%A7%A8%E8%8A%8B%E5%9C%93/249183082225052',
      price: 100,
      restaurant_type: '小吃',
      cuisine_types: ['甜點'],
      atmostphere: %w[歷史悠久],
      lat: 25.10798293955323,
      long: 121.84363926715822,
    },
    {
      name: '野事草店 Wild Herbs Gallery',
      intro:
        '是一間店，也是一場為期54個月用植物草本的食味創作。',
      address: '新北市瑞芳區輕便路147號',
      tel: '(02)23636268',
      website: 'https://www.facebook.com/wildherbs2018/',
      price: 600,
      restaurant_type: '餐廳',
      cuisine_types: %w[健康料理],
      atmostphere: %w[安靜 舒適休閒 藝術氛圍],
      lat: 25.10729103492388,
      long: 121.84179505366367,
    },
  ],
)
Hotel.create(
  name: '小洋樓民宿',
  website: '',
  star_rating: '',
  address: '新北市瑞芳區祈堂路172號',
  latitude: 25.10995150148696,
  longitude: 121.85804538249899,
  intro:
    '安山岩邊坡長出青苔綠芽，石板階上閃耀著疏落的光影，妳遠離城市，來到金瓜石探訪祈堂老街上的咖啡館與貓。沉浸在佇止的流金歲月裡，全世界恍若只剩自己的腳步聲。妳已行經一幢幢尖屋頂的古制日式木造屋舍，當小洋樓出現在轉角時，她立即吸引妳的目光。',
  hotel_types: '民宿',
  tel: '0981885933',
  images: '',
  equipment: %w[無線網路(WIFI) 行李存放],
)

romantics6 = {
  day1: [
    {
      name: '雲仙樂園',
      stay_time: 180,
      type: '景點',
      lat: 24.849124330970152,
      lng: 121.55118766899768,
    },
    {
      name: '泰雅美食餐廳',
      stay_time: 60,
      type: '餐廳',
      lat: 24.864969644111923,
      lng: 121.54826345365727,
    },
    {
      name: '烏來旅晨溫泉民宿',
      stay_time: 960,
      type: '住宿',
      lat: 24.865721757187764,
      lng: 121.54751999598689,
    },
  ],
  day2: [
    {
      name: '烏來老街',
      stay_time: 120,
      type: '景點',
      lat: 24.863911099866492,
      lng: 121.55141103831656,
    },
    {
      name: '烏來觀光台車',
      stay_time: 60,
      type: '景點',
      lat: 24.861528572955393,
      lng: 121.551156868998,
    },
    {
      name: '烏來海倫咖啡 (Helen Coffee Mobile Espresso)',
      stay_time: 60,
      type: '餐廳',
      lat: 24.861966006703813,
      lng: 121.5509128229756,
    },
  ],
}
categories = %w[浪漫]
Plan.create(
  name: '新北市烏來區浪漫之旅',
  description:
    '這個浪漫之旅包含了雲仙樂園、烏來老街、觀光台車等景點，以及泰雅美食餐廳、海倫咖啡等餐廳，還有烏來旅晨溫泉民宿提供住宿，讓遊客可以盡情享受烏來的美食與溫泉。',
  days: 2,
  locations: romantics6,
  user_id: 1,
  people: 2,
  public: true,
  category: categories.sample,
)
Site.create(
  [
    {
      name: '雲仙樂園',
      website: 'https://www.yun-hsien.com.tw/',
      address: '新北市烏來區瀑布路1-1號',
      latitude: 24.849124330970152,
      longitude: 121.55118766899768,
      stay_duration: 3,
      intro:
        '烏來位在台北市東南方約27公里，為新北市唯一的山地區，全區樹木青翠，清水長流，眾山環抱，聞名遐邇的烏來瀑布頂端源頭更是湖光山色，古木參天，林間雲霧濛濛，彩蝶、蟬鳴、鳥語彷如世外桃源。但此美景因南勢溪懸崖峭壁的阻隔讓遊客無法置身欣賞，於是興起了空中纜車籌建計劃，藉著空中纜車將原始自然景觀完整地呈現於遊客眼前，又因美景天成，春夏秋冬的演替各有不同之美就如同仙境般，所以取名為"雲仙樂園"。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 主題樂園 觀光勝地],
      tel: '(02)26616510',
      images: '',
      parking: '是',
    },
    {
      name: '烏來老街',
      website: 'https://newtaipei.travel/zh-tw',
      address: '新北市烏來區烏來街12號',
      latitude: 24.863911099866492,
      longitude: 121.55141103831656,
      stay_duration: 2,
      intro:
        '「烏來老街」指的就是烏來街、瀑布路與環山道路一帶，店家招牌樣式統一，看起相當整齊，而且大部分的商店都以原住民特色來發揮，所以遊客可以品嚐到原住民風味的山產美食，像是碳烤山豬肉、溫泉蛋、月桃飯、竹筒飯、馬告料理、山蘇、珠蔥等，都是其他地方少見的原住民風味料理，另外，還有小米酒、小米麻糬等特產，也都很適合分送給親朋好友當伴手禮，同時在這裡也可以觀賞到山地歌舞表演，感受原住民的熱情活力。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 觀光勝地],
      tel: '(02)26616442',
      images: '',
      parking: '是',
    },
    {
      name: '烏來觀光台車',
      website: 'https://recreation.forest.gov.tw/Forestry/FR?typ=11&typ_id=0200041',
      address: '新北市烏來區溫泉街86巷2號',
      latitude: 24.861528572955393,
      longitude: 121.551156868998,
      stay_duration: 2,
      intro:
        '遊客可搭乘舊時的木材車到林木茂密的山坡上，走訪健行步道和壯麗瀑布。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 觀光勝地],
      tel: '(02)26617826',
      images: '',
      parking: '否',
    },
  ],
)
Restaurant.create(
  [
    {
      name: '泰雅美食餐廳',
      intro:
     '原住民風味的美食。',
      address: '新北市烏來區環山路56號',
      tel: '0958563748',
      website: 'https://www.facebook.com/pages/%E6%B3%B0%E9%9B%85%E7%BE%8E%E9%A3%9F%E9%A4%90%E5%BB%B3/2276492709302842',
      price: 600,
      restaurant_type: '餐廳',
      cuisine_types: ['亞洲料理'],
      atmostphere: %w[熱鬧 舒適休閒],
      lat: 24.864969644111923,
      long: 121.54826345365727,
    },
    {
      name: '烏來海倫咖啡 (Helen Coffee Mobile Espresso)',
      intro:
    '位在新北市烏來的溫泉街上，這是一家戶外露天景觀咖啡館，享受下午茶幽靜紓壓時光，還能飽覽烏來絕佳美景，值得探訪！',
      address: '新北市烏來區溫泉街',
      tel: '(02)26616392',
      website: 'https://coffee-shop-1583.business.site/',
      price: 200,
      restaurant_type: '餐廳',
      cuisine_types: ['甜點'],
      atmostphere: %w[大自然 舒適休閒],
      lat: 24.861966006703813,
      long: 121.5509128229756,
    },
  ],
)
Hotel.create(
  name: '烏來旅晨溫泉民宿',
  website: 'https://re-change-wulai.mydirectstay.com/tw/index.html',
  star_rating: '',
  address: '新北市烏來區西羅岸路37號',
  latitude: 24.865721757187764,
  longitude: 121.54751999598689,
  intro:
    '烏來旅晨位於西羅岸路的高處，可以ㄧ覽烏來山水景色，加上大自然美麗的嚀聽瀑布蟲林鳥叫，再配上溫泉的洗滌使身心靈達到極致放鬆的程度。',
  hotel_types: '民宿',
  tel: '(02)26616658',
  images: '',
  equipment: %w[無線網路(WIFI) 行李存放 早餐服務 停車場/停車位],
)

romantics7 = {
  day1: [
    {
      name: '滬尾藝文休閒園區',
      stay_time: 180,
      type: '景點',
      lat: 25.176066209513365,
      lng: 121.42859899784146,
    },
    {
      name: 'Pescador Cafe 漁夫先生',
      stay_time: 60,
      type: '餐廳',
      lat: 25.174520483102974,
      lng: 121.43339591133586,
    },
    {
      name: '淡水老街',
      stay_time: 60,
      type: '景點',
      lat: 25.169232871448703,
      lng: 121.44408137078238,
    },
    {
      name: '淡水將捷金鬱金香酒店',
      stay_time: 960,
      type: '住宿',
      lat: 25.177271140231838,
      lng: 121.42964991133606,
    },
  ],
  day2: [
    {
      name: '紅毛城',
      stay_time: 120,
      type: '景點',
      lat: 25.175557302056312,
      lng: 121.43296487909292,
    },
    {
      name: '水灣餐廳waterfront 榕堤店',
      stay_time: 60,
      type: '餐廳',
      lat: 25.17226046695089,
      lng: 121.43638943832477,
    },
  ],
}
categories = %w[浪漫]
Plan.create(
  name: '新北市淡水區區浪漫之旅',
  description:
    '這個浪漫之旅包含淡水區著名景點和餐廳，並且提供淡水將捷金鬱金香酒店供住宿。遊程中包含滬尾藝文休閒園區、淡水老街、紅毛城等參觀景點，還有水灣餐廳提供美食體驗，是一個適合情侶、夫妻或情侶度假的浪漫行程',
  days: 2,
  locations: romantics7,
  user_id: 1,
  people: 2,
  public: true,
  category: categories.sample,
)
Site.create(
  [
    {
      name: '滬尾藝文休閒園區',
      website: 'https://www.fabmall.com.tw/',
      address: '新北市淡水區中正路一段2號',
      latitude: 25.176066209513365,
      longitude: 121.42859899784146,
      stay_duration: 3,
      intro:
        '位於淡水紅毛城旁，園區定位為休閒、藝文、生活、餐飲、跨界藝術展現與生活美學的一站式休閒消費環境，分別以購物商場、國際酒店呈現給大家。',
      pet_friendly: '可攜寵物',
      site_types: %w[購物中心 觀光勝地],
      tel: '(02)26265222',
      images: '',
      parking: '是',
    },
    {
      name: '淡水老街',
      website: 'http://tamsui.dils.tku.edu.tw/wiki/index.php/%E6%B7%A1%E6%B0%B4%E8%80%81%E8%A1%97%E5%BB%A3%E5%A0%B4',
      address: '新北市淡水區中正路1號',
      latitude: 25.169232871448703,
      longitude: 121.44408137078238,
      stay_duration: 2,
      intro:
        '小巧的徒步街道兩旁林立著商店和小吃攤販，有街頭表演者和雕塑。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 觀光勝地],
      tel: '(02)26221020',
      images: '',
      parking: '是',
    },
    {
      name: '紅毛城',
      website: 'https://www.tshs.ntpc.gov.tw/',
      address: '新北市淡水區中正路28巷1號',
      latitude: 25.175557302056312,
      longitude: 121.43296487909292,
      stay_duration: 2,
      intro:
    '這座山頂的西班牙堡壘建於 1629 年，可以俯瞰美麗的河景。',
      pet_friendly: '可攜寵物',
      site_types: %w[自然景觀 歷史文化遺產 觀光勝地],
      tel: '(02)26231001',
      images: '',
      parking: '是',
    },
  ],
)
Restaurant.create(
  [
    {
      name: 'Pescador Cafe 漁夫先生',
      intro:
        'Hey! 想找個悠閒的空間放鬆沉澱心情嗎?來我們 Pescador Cafe這!
      讓我輕輕陪伴你/妳些許時光，等你/妳的味蕾來發掘不一樣的世界.',
      address: '新北市淡水區中正路253號',
      tel: '(02)26209773',
      website: 'https://pescador-cafe.business.site/?utm_source=gmb&utm_medium=referral',
      price: 400,
      restaurant_type: '餐廳',
      cuisine_types: ['義式料理'],
      atmostphere: %w[安靜 舒適休閒],
      lat: 25.174520483102974,
      long: 121.43339591133586,
    },
    {
      name: '水灣餐廳waterfront 榕堤店',
      intro:
        '我們將榕樹葉形融入屋頂，當夕陽下山時，與榕樹葉型茅草相呼應，閃耀大自然的光芒。
        為呼應融合榕樹、淡水河景與紅磚外牆...選擇茅草、木頭與竹子等自然原始建材融入週邊環境！',
      address: '新北市淡水區中正路229-9號',
      tel: '(02)26290052',
      website: 'https://www.waterfront.com.tw/',
      price: 600,
      restaurant_type: '餐廳',
      cuisine_types: ['義式料理'],
      atmostphere: %w[大自然 舒適休閒],
      lat: 25.17226046695089,
      long: 121.43638943832477,
    },
  ],
)
Hotel.create(
  name: '淡水將捷金鬱金香酒店',
  website: 'https://re-change-wulai.mydirectstay.com/tw/index.html',
  star_rating: '4星級飯店',
  address: '新北市淡水區中正路一段2-1號',
  latitude: 25.177271140231838,
  longitude: 121.42964991133606,
  intro:
    '這間高級飯店位於淡水河對面，距離淡水捷運站和淡水漁人碼頭的木棧道 3 公里。步行11分鐘可達17世紀建造的紅毛城。',
  hotel_types: '飯店',
  tel: '(02)26210333',
  images: '',
  equipment: %w[無線網路(WIFI) 行李存放 早餐服務 停車場/停車位 游泳池 健身中心 酒吧/餐廳],
)
