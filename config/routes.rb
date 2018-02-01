Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations,:sessions]
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  root 'store/main_page#index'

  get 'products/:id', to: 'store/products#show', as: 'product'
  get 'categories/:id', to: 'store/categories#show', as: 'category'
  get 'catalog', to: 'store/catalog#index'
  get 'brands', to: 'store/manufacturers#index', as: 'brands'
  get 'shops', to: 'store/shops#index', as: 'shops'
  get 'promos', to: 'store/promos#index', as: 'promos'
  get 'promos/:id', to: 'store/promos#show', as: 'promo'


  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    get 'products_light', to: 'products_light#index', as: 'products_light'
    resources :activity_logs, only: [:index]
    resources :categories
    resources :collections
    resources :products
    resources :pictures
    resources :sale_sizes
    resources :product_types
    resources :sizes
    resources :incrustations
    resources :incrustation_items
    resources :metal_colors
    resources :metal_types
    resources :kits
    resources :manufacturers
    resources :shops
    resources :chain_types
    resources :promos
    resources :slides
    resources :main_page_blocks
    resources :users
    resource :users, only: [:update_password, :edit_password] do
      collection do
        patch ':id/update_password', to: 'users#update_password'
        get ':id/edit_password', to: 'users#edit_password', as: 'edit_password'
      end
    end
  end

end
