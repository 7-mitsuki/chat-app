Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users, only: %i[edit update]
  resources :rooms, only: %i[new create] do
    resources :messages, only: %i[index create]
  end
end
