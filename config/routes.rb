Rails.application.routes.draw do
  resources :search, only: :index

  root "search#index"
end
