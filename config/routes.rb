Rails.application.routes.draw do
  root 'posts#index'
  get 'users/index'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create, :show]

    resources :users
    resources :posts
    resources :favorites, only: [:create, :destroy, :index]
    # get '/favorites', to: 'favorites#index'

    resources :posts do
      collection do
        post :confirm
      end
    end

   mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  end
