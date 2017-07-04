require 'test_helper'

class MetalTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metal_type = metal_types(:one)
  end

  test "should get index" do
    get metal_types_url
    assert_response :success
  end

  test "should get new" do
    get new_metal_type_url
    assert_response :success
  end

  test "should create metal_type" do
    assert_difference('MetalType.count') do
      post metal_types_url, params: { metal_type: { title: @metal_type.title } }
    end

    assert_redirected_to metal_type_url(MetalType.last)
  end

  test "should show metal_type" do
    get metal_type_url(@metal_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_metal_type_url(@metal_type)
    assert_response :success
  end

  test "should update metal_type" do
    patch metal_type_url(@metal_type), params: { metal_type: { title: @metal_type.title } }
    assert_redirected_to metal_type_url(@metal_type)
  end

  test "should destroy metal_type" do
    assert_difference('MetalType.count', -1) do
      delete metal_type_url(@metal_type)
    end

    assert_redirected_to metal_types_url
  end
end
