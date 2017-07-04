require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { artikul: @product.artikul, manufacturer: @product.manufacturer, metal_color_id: @product.metal_color_id, old_size: @product.old_size, price: @product.price, priority: @product.priority, product_type_id: @product.product_type_id, sales_size_id: @product.sales_size_id, title: @product.title, to_main_page: @product.to_main_page, weight: @product.weight } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { artikul: @product.artikul, manufacturer: @product.manufacturer, metal_color_id: @product.metal_color_id, old_size: @product.old_size, price: @product.price, priority: @product.priority, product_type_id: @product.product_type_id, sales_size_id: @product.sales_size_id, title: @product.title, to_main_page: @product.to_main_page, weight: @product.weight } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
