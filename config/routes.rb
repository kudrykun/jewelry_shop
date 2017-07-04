Rails.application.routes.draw do
  root "products#index"
  resources :products
  resources :sale_sizes
  resources :product_types
  resources :sizes
  resources :incrustations
  resources :metal_colors
  resources :metal_types
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
