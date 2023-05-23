# Tourmind README

Tourmind 是一個用於協助旅行者計畫和組織旅行行程的平台，我們提供了以下功能和特點：
  - 行程規劃工具：旅行者可以使用行程規劃工具，輕鬆創建和管理他們的旅行行程。他們可以新增、編輯和刪除行程項目，設定日期和時間，並附上評論。
  - 交互式地圖：網站內建交互式地圖功能，旅行者可以在地圖上視覺化地標記和定位他們的行程項目。這使得他們能夠更清楚地了解他們的行程安排和地點之間的關係。
  - 喜愛清單：使用者可以將感興趣的地點或活動添加到喜愛清單中，以便稍後進行查看或將其添加到行程中。
  - 用戶註冊和登入：使用者可以註冊帳號並登入到他們的個人帳號，這使他們能夠保存和同步他們的行程和喜愛清單。
  
 * 我們希望這個行程規劃旅遊網站能夠提供一個方便和實用的工具，幫助旅行者順利計畫和享受他們的旅程。


- 使用技術：
  - 前端：HTML / CSS / Tailwind CSS / JavaScript / Stimulus JS
  - 後端：Ruby on Rails 
  - 部署：Fly.io
  - 資料庫：PostgreSQL
  - 版本控制：Git / GitHub
  - 其他：Postman
  
  
  ------------------------------------------------
  
  
- TourMind 成員：
  - 藍郁婷 https://github.com/YuTingLan
  - 楊士諒 https://github.com/yangliang0514
  - 許凱晴 https://github.com/Hsubetty
  - 翁全政 https://github.com/CCTWeng
  - 陳柏陞 https://github.com/chencac
  - 蕭維翔 https://github.com/weihsiang120


  ------------------------------------------------
  

- 啟動程式需先執行
  - bundle install
  - yarn install

- version
  - rails 6.1.7.3
  - ruby 3.2.0
  - node v16.19.0
  - PostgreSQL 14.7

- master.key
  - 編輯 vim
    - $EDITOR=vim rails credentials:edit
      - 設定 master.key
        - Google
          google_oauth_client_id:`your_id`
          google_oauth_client_secret:`your_key`

        - LINE
          line_client_id:`your_id`
          line_client_secret:`your_key`

        - Facebook
          facebook_client_id:`your_id`
          facebook_client_secret:`your_key`
          ＊測試需要使用 ngrok 服務

  - 查 Value
    - $Rails.application.credentials.dig(`:your_key`)

  - 快速新增假用戶與訂單(一次 20 筆)
    - rails data:generate_user
    - rails data:generate_order

  - 爬蟲新增飯店/景點/住宿(一次 20 筆)
    - rails data:generate_user
    - rails data:generate_sites
    - rails data:generate_restaurants
    - rails data:generate_hotels
    - rails data:generate_comment
    - rails data:generate_plans
