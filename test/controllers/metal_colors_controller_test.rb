require 'test_helper'

class MetalColorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metal_color = metal_colors(:one)
  end

  test "should get index" do
    get metal_colors_url
    assert_response :success
  end

  test "should get new" do
    get new_metal_color_url
    assert_response :success
  end

  test "should create metal_color" do
    assert_difference('MetalColor.count') do
      post metal_colors_url, params: { metal_color: { title: @metal_color.title } }
    end

    assert_redirected_to metal_color_url(MetalColor.last)
  end

  test "should show metal_color" do
    get metal_color_url(@metal_color)
    assert_response :success
  end

  test "should get edit" do
    get edit_metal_color_url(@metal_color)
    assert_response :success
  end

  test "should update metal_color" do
    patch metal_color_url(@metal_color), params: { metal_color: { title: @metal_color.title } }
    assert_redirected_to metal_color_url(@metal_color)
  end

  test "should destroy metal_color" do
    assert_difference('MetalColor.count', -1) do
      delete metal_color_url(@metal_color)
    end

    assert_redirected_to metal_colors_url
  end
end
