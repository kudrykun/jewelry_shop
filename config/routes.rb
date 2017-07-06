Rails.application.routes.draw do
  root "admin/products#index"
  namespace :admin do
    resources :collections
    resources :products
    resources :sale_sizes
    resources :product_types
    resources :sizes
    resources :incrustations
    resources :metal_colors
    resources :metal_types
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
