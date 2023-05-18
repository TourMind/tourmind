# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- 啟動程式需先執行

  - bundle install
  - yarn install

- version

  - rails 6.1.7.3
  - ruby 3.2.0
  - node v16.19.0
  - postgres (PostgreSQL) 14.7 (Homebrew)

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

- TourMind 成員：
  - 藍郁婷 https://github.com/YuTingLan
  - 楊士諒 https://github.com/yangliang0514
  - 許凱晴 https://github.com/Hsubetty
  - 翁全政 https://github.com/CCTWeng
  - 陳柏陞 https://github.com/chencac
  - 蕭維翔 https://github.com/weihsiang120
