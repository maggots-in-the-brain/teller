Rails.application.routes.draw do 
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
  end
end
