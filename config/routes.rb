Rails.application.routes.draw do

  root :to => "brands#login"
  get "/login" => "brands#login"
  post "/login" => "brands#logon"
  get "/logout" => "brands#logout"

  resources :photos, only: [:new, :create, :index, :destroy]
  resources :brands do
    resources :series do
      resources :series_background_images, only: [:create, :destroy]
    end
  end
  get '/series/find/:brand_id' => "series#find_series"

  resources :details do
    resources :p_metadata
    #  do
      # resources :qr_images, only: [:create, :destroy]
    # end
    resources :detail_images, only: [:new, :create, :index, :destroy]
    resources :composition_images, only: [:new, :create, :index, :destroy]
    resources :feature_images, only: [:new, :create, :index, :destroy]
    resources :content_images, only: [:new, :create, :index, :destroy]
    resources :qr_images, only: [:new, :create, :index, :destroy]
  end

  resources :plains, only: [:new, :create, :index, :destroy, :edit] do
    resources :plain_details, only: [:create, :update, :destroy]
    member do
      get 'update' => "plain_details#update_deatils"
      post 'update' => "plain_details#update_deatils"
    end
  end

  get '/details_listall' => 'details#detail_info_list'
  get '/details/:detail_id/image_upload' => 'details#image_upload'

  resources :machines, only: [:index, :update] do
    member do
      get 'sync' => "machines#sync_plain_to_machine"
      get 'sync_video' => "machines#sync_vidoe_plain_to_machine"
    end
  end
  # get '/testxml' => 'machines#sync_plain_to_machine'

  resources :backups, only: [:index, :create]
  post '/backups/generate' => "backups#generate"
  get '/backups/genpage' => "backups#genpage"
  resources :video_plains, except: [:show]
  resources :videos, only: [:destroy, :create, :edit]
end
