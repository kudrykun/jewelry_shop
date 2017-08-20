Rails.application.routes.draw do
  root 'store/main_page#index'
  get 'product/:id', to: 'store/product#show', as: 'product'


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
  end

end
