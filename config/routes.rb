Rails.application.routes.draw do
  root to: 'landing#show'

  resources :players, only: [:index, :show, :update] do
    get :search, on: :collection
    put :update_ranks, on: :member
  end
  resources :playlist_ranks, only: [:index]
  resources :weapon_usages, only: [:index]
end
