# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
      image:
        "https://lh3.googleusercontent.com/p/AF1QipNUlESGRGoTRr1TSegH69b-HTb68JG0ZVfAguHs=w768-h432-p-no-v0",
      address: "新北市永和區,得和路373巷,3號",
      tel: "0908032183",
      website: "https://timely-noodle.business.site/",
      price: 120,
      restaurant_type: 2,
      lat: 24.999679401438087,
      long: 121.52457507851321,
    },
  ],
)

Restaurant.create!(
  [
    {
      name: "La MESA 忠孝",
      intro:
        "Contemporary tapas restaurant in the heart of Taipei with menu designed by Chef Paco.",
      image:
        "https://lh5.googleusercontent.com/p/AF1QipPpvX2P9KZYCzsImzvgpVi4dGrJOOJ6_zdSaAWz=w408-h616-k-no",
      address: "台北市大安區,延吉街137巷,33號",
      tel: "(02)27787676",
      website: "https://www.facebook.com/LaMESAtw/",
      price: 1200,
      restaurant_type: 0,
      cuisine_types: %w[美式料理 法式料理],
      atmostphere: %w[浪漫 舒適休閒],
      lat: 25.042242922714284,
      long: 121.55562939566491,
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
      image:
        "https://lh5.googleusercontent.com/p/AF1QipNR42vUI4U_lJwv5t19ruCiodWaN8c8lD8XI1OL=w408-h427-k-no",
      address: "台北市大安區,復興南路二段,17號",
      tel: "(02)37076891",
      website: "https://www.smartkitchen.tw/",
      price: 200,
      restaurant_type: 0,
      cuisine_types: ["中式料理"],
      atmostphere: %w[安靜 舒適休閒],
      lat: 25.032374793862548,
      long: 121.54360533614681,
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
