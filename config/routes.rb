Rails.application.routes.draw do
  root to: 'landing#show'

  resources :players, only: [:show] do
    collection do
      post :search
    end
  end
end
