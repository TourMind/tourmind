# frozen_string_literal: true

Rails.application.routes.draw do
  root 'page#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :comments

  # 升級方案
  get '/pricing', to: 'page#pricing'
  # 金流路徑
  post '/pricing/return', to: 'page#return'
  post '/pricing/notify', to: 'page#notify'
  # 付款成功
  get '/pricing/paymentok', to: 'page#paymentok'
  # 訂單資訊
  get '/pricing/oder', to: 'page#oder'
end
