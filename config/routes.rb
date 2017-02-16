Rails.application.routes.draw do
  resources :doses, only: [:destroy]
  resources :cocktails do
    resources :doses, only: [:new, :create]
  end
end
