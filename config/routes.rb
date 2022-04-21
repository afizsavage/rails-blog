Rails.application.routes.draw do
  devise_for :users
  get 'likes/create'
  get 'comments/create'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[create new destroy]
      resources :likes, only: %i[create]
    end
  end

  root to: 'users#index'
end
