Rails.application.routes.draw do
  resources :restaurants
  resources :plans
  get "/day_info", to: "plans#day_info"
  get "/plan_overview", to: "plans#plan_overview"
end
