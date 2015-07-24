require 'test_helper'

class KeywordIgnoresControllerTest < ActionController::TestCase
  setup do
    @keyword_ignore = keyword_ignores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyword_ignores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyword_ignore" do
    assert_difference('KeywordIgnore.count') do
      post :create, keyword_ignore: { image_mst_id: @keyword_ignore.image_mst_id, keyword_mst_id: @keyword_ignore.keyword_mst_id }
    end

    assert_redirected_to keyword_ignore_path(assigns(:keyword_ignore))
  end

  test "should show keyword_ignore" do
    get :show, id: @keyword_ignore
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keyword_ignore
    assert_response :success
  end

  test "should update keyword_ignore" do
    patch :update, id: @keyword_ignore, keyword_ignore: { image_mst_id: @keyword_ignore.image_mst_id, keyword_mst_id: @keyword_ignore.keyword_mst_id }
    assert_redirected_to keyword_ignore_path(assigns(:keyword_ignore))
  end

  test "should destroy keyword_ignore" do
    assert_difference('KeywordIgnore.count', -1) do
      delete :destroy, id: @keyword_ignore
    end

    assert_redirected_to keyword_ignores_path
  end
end
