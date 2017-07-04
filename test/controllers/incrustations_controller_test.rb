require 'test_helper'

class IncrustationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incrustation = incrustations(:one)
  end

  test "should get index" do
    get incrustations_url
    assert_response :success
  end

  test "should get new" do
    get new_incrustation_url
    assert_response :success
  end

  test "should create incrustation" do
    assert_difference('Incrustation.count') do
      post incrustations_url, params: { incrustation: { title: @incrustation.title } }
    end

    assert_redirected_to incrustation_url(Incrustation.last)
  end

  test "should show incrustation" do
    get incrustation_url(@incrustation)
    assert_response :success
  end

  test "should get edit" do
    get edit_incrustation_url(@incrustation)
    assert_response :success
  end

  test "should update incrustation" do
    patch incrustation_url(@incrustation), params: { incrustation: { title: @incrustation.title } }
    assert_redirected_to incrustation_url(@incrustation)
  end

  test "should destroy incrustation" do
    assert_difference('Incrustation.count', -1) do
      delete incrustation_url(@incrustation)
    end

    assert_redirected_to incrustations_url
  end
end
