Rails.application.routes.draw do
  get '/m/:key' => "short_urls#travel", as: :travel

  resources :short_urls, except: [:index]

  root 'short_urls#new'
end
