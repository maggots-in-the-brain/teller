Rails.application.routes.draw do
  scope module: :public do
    root 'homes#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
