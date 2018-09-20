Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  resources :news, only: :index
  post 'new', to: 'news#create'
end
