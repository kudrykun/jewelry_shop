# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
Rails.application.config.assets.precompile += %w( admin/admin.css )
Rails.application.config.assets.precompile += %w( store/store.css )
Rails.application.config.assets.precompile += %w( admin/admin.js )
Rails.application.config.assets.precompile += %w( admin/product/dz-scripts.js )
Rails.application.config.assets.precompile += %w( admin/product/product_price.js )
Rails.application.config.assets.precompile += %w( store/store.js )
Rails.application.config.assets.precompile += %w( store/main_page/main_page.js )
Rails.application.config.assets.precompile += %w( store/catalog/catalog.js )
Rails.application.config.assets.precompile += %w( store/categories/categories.js )
Rails.application.config.assets.precompile += %w( store/product/product.js )
Rails.application.config.assets.precompile += %w( filterrific/filterrific-spinner.gif )
