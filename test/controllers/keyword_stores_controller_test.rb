require 'test_helper'

class KeywordStoresControllerTest < ActionController::TestCase
  setup do
    @keyword_store = keyword_stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyword_stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyword_store" do
    assert_difference('KeywordStore.count') do
      post :create, keyword_store: { image_mst_id: @keyword_store.image_mst_id, keyword_mst_id: @keyword_store.keyword_mst_id }
    end

    assert_redirected_to keyword_store_path(assigns(:keyword_store))
  end

  test "should show keyword_store" do
    get :show, id: @keyword_store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keyword_store
    assert_response :success
  end

  test "should update keyword_store" do
    patch :update, id: @keyword_store, keyword_store: { image_mst_id: @keyword_store.image_mst_id, keyword_mst_id: @keyword_store.keyword_mst_id }
    assert_redirected_to keyword_store_path(assigns(:keyword_store))
  end

  test "should destroy keyword_store" do
    assert_difference('KeywordStore.count', -1) do
      delete :destroy, id: @keyword_store
    end

    assert_redirected_to keyword_stores_path
  end
end
