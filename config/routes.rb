Rails.application.routes.draw do
  devise_for :users
  root to: 'textbooks#index'
  resources :textbooks, only: [:new, :create]
end
