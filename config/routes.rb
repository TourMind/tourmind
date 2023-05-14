# frozen_string_literal: true

Rails.application.routes.draw do
  root 'page#home'

  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks',
             }

  resources :favorites, only: %i[index create destroy]
  resources :restaurants do
    resources :comments, only: [:create,:new]
  end

  resources :plans do 
    resources :comments
  end

  # 行程相關路性
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


  resources :hotels do
    resources :comments, only: [:create,:new]
  end

  resources :sites do
    resources :comments, only: [:create,:new]
  end 
end
