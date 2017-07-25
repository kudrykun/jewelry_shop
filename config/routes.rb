Rails.application.routes.draw do
  root 'admin/dashboard#index'

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
    resources :metal_colors
    resources :metal_types
    resources :kits
    resources :manufacturers
  end

end
