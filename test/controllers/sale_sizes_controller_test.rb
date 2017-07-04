require 'test_helper'

class SaleSizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale_size = sale_sizes(:one)
  end

  test "should get index" do
    get sale_sizes_url
    assert_response :success
  end

  test "should get new" do
    get new_sale_size_url
    assert_response :success
  end

  test "should create sale_size" do
    assert_difference('SaleSize.count') do
      post sale_sizes_url, params: { sale_size: { sale_percent: @sale_size.sale_percent } }
    end

    assert_redirected_to sale_size_url(SaleSize.last)
  end

  test "should show sale_size" do
    get sale_size_url(@sale_size)
    assert_response :success
  end

  test "should get edit" do
    get edit_sale_size_url(@sale_size)
    assert_response :success
  end

  test "should update sale_size" do
    patch sale_size_url(@sale_size), params: { sale_size: { sale_percent: @sale_size.sale_percent } }
    assert_redirected_to sale_size_url(@sale_size)
  end

  test "should destroy sale_size" do
    assert_difference('SaleSize.count', -1) do
      delete sale_size_url(@sale_size)
    end

    assert_redirected_to sale_sizes_url
  end
end
