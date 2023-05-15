# frozen_string_literal: true

Rails.application.routes.draw do
  root 'page#home'

  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks',
               passwords: 'users/passwords'
             }

  resources :favorites, only: %i[index create destroy]
  resources :restaurants do
    resources :comments, only: [:create,:new]
  end

  resources :plans do 
    post 'add_editor', on: :member
    delete 'editor/:user_id', to: 'plans#remove_editor' , on: :member
    resources :comments
  end

  # 行程相關路徑
  get '/check_user', to: 'plans#check_user'
  get '/day_info', to: 'plans#day_info'
  get '/plan_overview', to: 'plans#plan_overview'

  resources :comments

  # 升級方案
  get '/pricing', to: 'page#pricing'
  # 金流路徑
  post '/pricing/return', to: 'page#return'
  post '/pricing/notify', to: 'page#notify'
  # 付款成功
  get '/pricing/paymentok', to: 'page#paymentok'
  # 訂單資訊
  resources :orders, only: %i[index show]
  # 管理員後台
  get '/dashboard/users', to: 'dashboard#users', as: 'dashboard_users'
  get '/dashboard/hotels', to: 'dashboard#hotels', as: 'dashboard_hotels'

  # 404畫面
  get '/404', to: "application#record_not_found"

  resources :hotels do
    resources :comments, only: [:create,:new]
  end

  resources :sites do
    resources :comments, only: [:create,:new]
  end 
end
