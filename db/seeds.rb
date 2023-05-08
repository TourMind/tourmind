# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.destroy_all

Restaurant.create!(
  [
    {
      name: "甘霖涼麵-永和店",
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
      address: "新北市永和區,得和路373巷,3號",
      tel: "0908032183",
      website: "https://timely-noodle.business.site/",
      price: 120,
      restaurant_type: "台灣小吃/台菜",
      atmostphere: %w[舒適休閒],
      lat: 24.999679401438087,
      long: 121.52457507851321,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "Osteria Rialto 雅朵義大利餐館",
      intro:
        "每次行經國父紀念館站看到『Osteria Rialto雅朵義大利餐館』店裡店外都是歐美臉孔，好像台北街頭看到的外國人都聚集在這了，而此情此景反射在我腦海的第一個念頭便是『Osteria Rialto雅朵義大利餐館』肯定口味道地，不然就是老闆主廚是外國人…，事後應證了我的直覺，沒錯，『Osteria Rialto雅朵義大利餐館』不論披薩、義大利麵以及各種開胃菜無一不精彩，而且主廚就是義大利人!!",
      address: "台北市大安區,光復南路260巷,5號",
      tel: "(02)27781536",
      website: "https://www.facebook.com/osteriarialto/?locale=zh_TW",
      price: 800,
      restaurant_type: "餐廳",
      cuisine_types: %w[義式料理],
      atmostphere: %w[浪漫 舒適休閒],
      lat: 25.039967,
      long: 121.5541516,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "聰哥食堂 大安店",
      intro:
        "五十年前，一個來自於嘉義鄉下的孩子，靠自己的努力考上台大，
畢業後成為跨國企業會計師，數十年的職場生活並未減少他對美食的熱情。
身為家中長子的他從小就要幫忙燒飯，
對料理產生濃厚的興趣，燒的一手好菜。
他，就是創辦人—文聰哥
退休後，文聰哥將自己私藏手路菜食譜集合起來，
創辦「聰哥食堂」，將一道道的佳餚飄香入你我的日常。",
      address: "台北市大安區,復興南路二段,17號",
      tel: "(02)37076891",
      website: "https://www.smartkitchen.tw/",
      price: 200,
      restaurant_type: '餐廳',
      cuisine_types: ["中式料理"],
      atmostphere: %w[安靜 舒適休閒],
      lat: 25.032374793862548,
      long: 121.54360533614681,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "小小樹食-敦南店",
      intro:
        "「小小樹食」強調真食物，堅持不使用加工品，食材來源必得講究。 在餐點中出現的少見生菜，如俄羅斯羽衣甘藍、京水菜、寶貝波菜、紅橡木萵苣、櫻桃蘿蔔；以及季節性的櫛瓜、櫛瓜花、墨西哥辣椒等，都出自自然農法耕作的農場。 呈現「新加州料理」，必備重要食材便是香甜肉厚的酪梨，但在台灣品質良好、如同滑順奶油般口感的酪梨多半仰賴進口。",
      address: "台北市大安區,敦化南路二段,39號",
      tel: "(02)27000313",
      website: "https://www.facebook.com/LittleTreeFood/about?locale=zh_TW",
      price: 400,
      restaurant_type: '餐廳',
      cuisine_types: %w[健康料理 法式料理],
      atmostphere: %w[安靜 舒適休閒 藝術氛圍],
      lat: 25.0315979,
      long: 121.5492167,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "CIN CIN OSTERIA 請請義大利餐廳",
      intro:
        "是一家蠻平價的義式餐廳，義大利麵和pizza約200多，對於店內的用料印象深刻，真材實料食材新鮮，是一家cp值很高的餐廳! 店內氣氛歡樂(大家的各種喧鬧聲)，是一個多人聚會的好選項",
      address: "台北市信義區,逸仙路50巷,22號",
      tel: "(02)27122050",
      website: "https://www.facebook.com/cincinosteria/",
      price: 400,
      restaurant_type: '餐廳',
      cuisine_types: ["義式料理"],
      atmostphere: %w[熱鬧 舒適休閒],
      lat: 25.0405367,
      long: 121.5246863,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "Gelovery Gift 法式甜點店",
      intro:
        "「Gelovery Gift 蒟若妮法式甜點店」，號稱「台北最美甜點」，還記得在東區開幕時可是引起一股熱絡的風潮，甚至還沒開始營業，門口都已經有客人在等候，當時看到它們家的甜點櫃時，妳真的會被驚豔到每款都想吃，但有些限量的早早就被搶光，有錢你還不見得吃的到！",
      address: "台北市大安區,大安路一段51巷,27號",
      tel: "(02)27317862",
      website: "https://www.geloverygift.com/",
      price: 300,
      restaurant_type: '甜點',
      atmostphere: %w[安靜 舒適休閒],
      lat: 25.0418702,
      long: 121.5348735,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "泰市場 Spice Market",
      intro:
        "台北市唯一一家五星級泰式海鮮自助料理餐廳，豐美海鮮滿佈餐檯，泰式辛香料理引人食指大動，從開胃冷菜、熱炒、湯品、咖哩、沙爹到奶茶、冰淇淋和甜品糕點，帶給食客視覺與味覺的雙重美味饗宴。",
      address: "台北市信義區,松高路,11號",
      tel: "(02)87860029",
      website: "https://www.regenttaiwan.com/dining/outside-dining/spice-market",
      price: 1200,
      restaurant_type: '餐廳',
      cuisine_types: %w[海鮮料理 泰式料理],
      atmostphere: %w[熱鬧],
      lat: 25.0395349,
      long: 121.5656192,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "GYUU NIKU ステーキ專門店",
      intro:
        "來自日本的GYUU NIKU ステーキ專門店，特選Choice級牛排使用烤箱低溫烘烤的火山丼、酥脆黃金麵衣搭配菲力牛肉的炸牛排，搭配鮮甜濃郁的牛尾湯，給您不一樣的丼飯饗受！",
      address: "台北市信義區,忠孝東路五段,412號",
      tel: "(02)87800002",
      website: "https://www.facebook.com/GYUUTW",
      price: 300,
      restaurant_type: '餐廳',
      cuisine_types: ["日式料理"],
      atmostphere: %w[熱鬧 舒適休閒],
      lat: 25.0404527,
      long: 121.5731091,
    },
  ],
)

sites = {
  day1: [
    {
      name: "台北市立美術館",
      stay_time: 20,
      type: "景點",
      lat: 25.07261585329631,
      lng: 121.52475655161953,
    },
    {
      name: "華山1914文化創意產業園區",
      stay_time: 65,
      type: "景點",
      lat: 25.044244740152156,
      lng: 121.52932610929034,
    },
    {
      name: "饒河街觀光夜市",
      stay_time: 100,
      type: "餐廳",
      lat: 25.05108758917027,
      lng: 121.57745638045473,
    },
  ],
  day2: [
    {
      name: "國立故宮博物院",
      stay_time: 10,
      type: "景點",
      lat: 25.102512574287264,
      lng: 121.54849837133887,
    },
    {
      name: "北投溫泉區",
      stay_time: 38,
      type: "景點",
      lat: 25.13671194396663,
      lng: 121.50716520347267,
    },
    {
      name: "台北101觀景台",
      stay_time: 73,
      type: "景點",
      lat: 25.034287433437417,
      lng: 121.5640104669617,
    },
  ],
}

sites2 = {
  day1: [
    {
      name: "國立故宮博物院",
      stay_time: 20,
      type: "景點",
      lat: 25.102512574287264,
      lng: 121.54849837133887,
    },
    {
      name: "臺北101",
      stay_time: 30,
      type: "夜景",
      lat: 25.034287433437417,
      lng: 121.5640104669617,
    },
  ],
  day2: [
    {
      name: "陽明山國家公園",
      stay_time: 20,
      type: "景點",
      lat: 25.194498590641256,
      lng: 121.56089338045958,
    },
    {
      name: "北投區溫泉博物館",
      stay_time: 25,
      type: "溫泉",
      lat: 25.13671194396663,
      lng: 121.50716520347267,
    },
    {
      name: "士林官邸",
      stay_time: 35,
      type: "景點",
      lat: 25.093396983931115,
      lng: 121.53232659816169,
    },
  ],
  day3: [
    {
      name: "象山",
      stay_time: 15,
      type: "戶外",
      lat: 25.02742219851901,
      lng: 121.57654284502128,
    },
    {
      name: "中正紀念堂",
      stay_time: 40,
      type: "景點",
      lat: 25.035774267485415,
      lng: 121.5202357215834,
    },
  ],
}

categories = %w[自然 文化 美食 冒險 休閒 浪漫 音樂 藝術]

10.times do
  Plan.create!(
    name: "臺北城市文化探險之旅",
    description:
      "這個兩天的行程將帶你遊覽臺北市的文化、美食、自然和現代化等多個方面。第一天，您將參觀台灣藝術家的作品，探索熱鬧的藝文場所，品嚐當地美食。第二天，您將欣賞中國古代文物和藝術品，放鬆身心，欣賞城市全景。這個行程適合喜歡城市探險和文化體驗的旅行者。",
    days: 2,
    locations: sites,
    user_id: 1,
    public: true,
    category: categories.sample,
  )

  Plan.create!(
    name: "臺北城市自然和現代化之旅",
    description:
      "這個三天的行程將帶你遊覽臺北市的文化、美食、自然和現代化等多個方面。第一天，您將欣賞中國古代藝術品、探索著名的夜市、欣賞現代化建築的壯觀。第二天，您將欣賞壯麗的自然風光、探索台灣溫泉的歷史和文化。",
    days: 3,
    locations: sites2,
    user_id: 1,
    public: true,
    category: categories.sample,
  )
end
