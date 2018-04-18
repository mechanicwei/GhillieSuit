Rails.application.routes.draw do
  get '/m/:key' => "short_urls#travel", as: :travel

  resources :short_urls, except: [:index]

  root 'short_urls#new'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :short_urls, only: [:create, :update, :destroy, :show]
    end
  end
end
