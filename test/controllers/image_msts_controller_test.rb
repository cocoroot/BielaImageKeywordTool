require 'test_helper'

class ImageMstsControllerTest < ActionController::TestCase
  setup do
    @image_mst = image_msts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:image_msts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image_mst" do
    assert_difference('ImageMst.count') do
      post :create, image_mst: { filename: @image_mst.filename }
    end

    assert_redirected_to image_mst_path(assigns(:image_mst))
  end

  test "should show image_mst" do
    get :show, id: @image_mst
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @image_mst
    assert_response :success
  end

  test "should update image_mst" do
    patch :update, id: @image_mst, image_mst: { filename: @image_mst.filename }
    assert_redirected_to image_mst_path(assigns(:image_mst))
  end

  test "should destroy image_mst" do
    assert_difference('ImageMst.count', -1) do
      delete :destroy, id: @image_mst
    end

    assert_redirected_to image_msts_path
  end
end
