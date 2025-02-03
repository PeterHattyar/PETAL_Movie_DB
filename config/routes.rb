Rails.application.routes.draw do
  root  "movies#index"

 resources :articles
 resources :movies
end
