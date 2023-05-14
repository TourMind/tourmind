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

  resources :payments, only: [] do
    collection do
      get :ok  # 付款成功
      post :return  # 金流路徑
      post :notify  # 金流路徑
    end
  end

  # 訂單資訊
  resources :orders, only: %i[index show]

  # 管理員後台
  namespace :dashboard do
    get :users  # /dashboard/users
    get :hotels # /dashboard/hotels
    get :sites # /dashboard/sites
    get :restaurants # /dashboard/restaurants
  end

  # 404畫面
  get '/404', to: "application#record_not_found"
  get 'search', to: 'page#search'

  resources :hotels do
    resources :comments, only: [:create,:new]
  end

  resources :sites do
    resources :comments, only: [:create,:new]
  end 
end
