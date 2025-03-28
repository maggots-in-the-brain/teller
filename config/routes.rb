Rails.application.routes.draw do 
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }

  scope module: :public do
    root 'homes#top'
    resources :posts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
