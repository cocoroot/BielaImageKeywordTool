require 'test_helper'

class SimilarImagesControllerTest < ActionController::TestCase
  setup do
    @similar_image = similar_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:similar_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create similar_image" do
    assert_difference('SimilarImage.count') do
      post :create, similar_image: { image_msts_id: @similar_image.image_msts_id, inner_product: @similar_image.inner_product, keyword_msts_id: @similar_image.keyword_msts_id }
    end

    assert_redirected_to similar_image_path(assigns(:similar_image))
  end

  test "should show similar_image" do
    get :show, id: @similar_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @similar_image
    assert_response :success
  end

  test "should update similar_image" do
    patch :update, id: @similar_image, similar_image: { image_msts_id: @similar_image.image_msts_id, inner_product: @similar_image.inner_product, keyword_msts_id: @similar_image.keyword_msts_id }
    assert_redirected_to similar_image_path(assigns(:similar_image))
  end

  test "should destroy similar_image" do
    assert_difference('SimilarImage.count', -1) do
      delete :destroy, id: @similar_image
    end

    assert_redirected_to similar_images_path
  end
end
