# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.create!([{
                     name: '甘霖涼麵-永和店',
                     intro: '我們是涼麵店，也有賣熱拌麵
  今天我想推薦給您 #純粹乾拌麵
  就是在這樣的天氣才會這樣的想起這碗麵
  使用純醬拌麵，沒有五光十色的過度調味
  淡黃色Q彈的麵條，完整吸附醬汁
  加上些許燙青菜
  入口後青菜的清脆與麵條的口感千絲萬縷
  輕鬆補充每日必須養分與熱量
  給您一碗單純的好味道
  滿足味覺...',
                     image: 'https://lh3.googleusercontent.com/p/AF1QipNUlESGRGoTRr1TSegH69b-HTb68JG0ZVfAguHs=w768-h432-p-no-v0',
                     address: '新北市永和區,得和路373巷,3號',
                     section: '永和區',
                     tel: '0908032183',
                     website: 'https://timely-noodle.business.site/',
                     price: 120,
                     restaurant_type: 2
                   }])

Restaurant.create!([{
  name: 'La MESA 忠孝',
  intro: 'Contemporary tapas restaurant in the heart of Taipei with menu designed by Chef Paco.',
  image: 'https://lh5.googleusercontent.com/p/AF1QipPpvX2P9KZYCzsImzvgpVi4dGrJOOJ6_zdSaAWz=w408-h616-k-no',
  address: '台北市大安區,延吉街137巷,33號',
  section: '大安區',
  tel: '02 2778 7676',
  website: 'https://www.facebook.com/LaMESAtw/',
  price: 1200,
  restaurant_type: 0,
  cuisine_types: ['美式料理','法式料理'],
  atmostphere: ['浪漫','舒適休閒'],
}])

Restaurant.create!([{
  name: '聰哥食堂 大安店',
  intro: '五十年前，一個來自於嘉義鄉下的孩子，靠自己的努力考上台大，
畢業後成為跨國企業會計師，數十年的職場生活並未減少他對美食的熱情。
身為家中長子的他從小就要幫忙燒飯，
對料理產生濃厚的興趣，燒的一手好菜。
他，就是創辦人—文聰哥
退休後，文聰哥將自己私藏手路菜食譜集合起來，
創辦「聰哥食堂」，將一道道的佳餚飄香入你我的日常。',
  image: 'https://lh5.googleusercontent.com/p/AF1QipNR42vUI4U_lJwv5t19ruCiodWaN8c8lD8XI1OL=w408-h427-k-no',
  address: '台北市大安區,復興南路二段,17號',
  section: '大安區',
  tel: '02 3707 6891',
  website: 'https://www.smartkitchen.tw/',
  price: 200,
  restaurant_type: 0,
  cuisine_types: ['中式料理'],
  atmostphere: ['安靜','舒適休閒'],
}])


