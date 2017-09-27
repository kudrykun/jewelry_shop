Rails.application.routes.draw do
  root 'store/main_page#index'

  get 'products/:id', to: 'store/products#show', as: 'product'
  get 'categories/:id', to: 'store/categories#show', as: 'category'
  get 'catalog', to: 'store/catalog#index'


  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
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
  end

end
