Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "brands#index"
  resources :photos, only: [:new, :create, :index, :destroy]
  resources :brands do
    resources :series
  end

  resources :details do
    resources :detail_images, only: [:new, :create, :index, :destroy]
    resources :composition_images, only: [:new, :create, :index, :destroy]
    resources :feature_images, only: [:new, :create, :index, :destroy]
  end
  get '/cc' => "details#cc"

end
