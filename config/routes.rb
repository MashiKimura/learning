Rails.application.routes.draw do
  devise_for :users
  root to: 'textbooks#index'
  resources :textbooks, only: [:new, :create, :show, :destroy] do
    resources :records, only: [:new, :create, :edit, :update, :destroy]
    resources :goals, only: [:edit, :update]
  end
  
end
