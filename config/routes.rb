# frozen_string_literal: true

Rails.application.routes.draw do
  root 'page#home'
  # resources :passwords, only: [:edit, :update]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :restaurants
  resources :plans
  get "/day_info", to: "plans#day_info"
  get "/plan_overview", to: "plans#plan_overview"
end
