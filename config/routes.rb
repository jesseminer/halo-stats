Rails.application.routes.draw do
  root to: 'landing#show'

  resources :players, only: [:index, :show, :update] do
    collection do
      post :search
    end
  end
  resources :playlist_ranks, only: [:index]
  resources :weapon_usages, only: [:index]
end
