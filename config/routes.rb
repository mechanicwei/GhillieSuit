Rails.application.routes.draw do
  resources :short_urls, except: [:index]
end
