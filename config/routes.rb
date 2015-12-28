Rails.application.routes.draw do
  resources :players, only: [:show] do
    collection do
      post :search
    end
  end
end
