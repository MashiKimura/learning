Rails.application.routes.draw do
  devise_for :users
  root to: 'learnings#index'
  resources :learnings, only: [:index]
end
