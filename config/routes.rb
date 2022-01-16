Rails.application.routes.draw do
  devise_for :users
  root to: 'textbooks#index'
  resources :textbooks, only: [:new, :create] do
    resources :records, only: [:new, :create]
  end
end
