json.extract! product, :id, :title, :artikul, :price, :metal_color_id, :weight, :product_type_id, :sales_size_id, :old_size, :to_main_page, :manufacturer, :priority, :created_at, :updated_at
json.url product_url(product, format: :json)
