Rails.application.routes.draw do 
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/admins/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }

  scope module: :public do
    root 'homes#top'
    resources :posts do
      resources :post_comments, only: [:create]
    end
    resources :post_comments, only: [:destroy]
    post 'guest_login', to: 'users#guest_login'
  end

  namespace :admin do
    root 'users#index'
    resources :users, only: [:index, :show, :destroy]
    resources :post_comments, only: [:index, :destroy]
  end
end
