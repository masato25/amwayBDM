Rails.application.routes.draw do
  resources :machines, only: [:index, :update]

  # get 'plain_details/create'

  # get 'plain_details/destory'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "brands#index"
  resources :photos, only: [:new, :create, :index, :destroy]
  resources :brands do
    resources :series
  end
  get '/series/find/:brand_id' => "series#find_series"


  resources :details do
    resources :p_metadata do
      resources :qr_images, only: [:create, :destroy]
    end
    resources :detail_images, only: [:new, :create, :index, :destroy]
    resources :composition_images, only: [:new, :create, :index, :destroy]
    resources :feature_images, only: [:new, :create, :index, :destroy]
  end

  resources :plains, only: [:new, :create, :index, :destroy, :edit] do
    resources :plain_details, only: [:create, :update, :destroy]
  end

  get '/details_listall' => 'details#detail_info_list'
  get '/details/:detail_id/image_upload' => 'details#image_upload'

end
