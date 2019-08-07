require 'test_helper'

class MerchantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @merchant = merchants(:one)
  end

  test "should get index" do
    get merchants_url, as: :json
    assert_response :success
  end

  test "should create merchant" do
    assert_difference('Merchant.count') do
      post merchants_url, params: { merchant: { name: @merchant.name, user_id: @merchant.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show merchant" do
    get merchant_url(@merchant), as: :json
    assert_response :success
  end

  test "should update merchant" do
    patch merchant_url(@merchant), params: { merchant: { name: @merchant.name, user_id: @merchant.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy merchant" do
    assert_difference('Merchant.count', -1) do
      delete merchant_url(@merchant), as: :json
    end

    assert_response 204
  end
end
