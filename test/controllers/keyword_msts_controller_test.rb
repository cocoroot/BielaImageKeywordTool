require 'test_helper'

class KeywordMstsControllerTest < ActionController::TestCase
  setup do
    @keyword_mst = keyword_msts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyword_msts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyword_mst" do
    assert_difference('KeywordMst.count') do
      post :create, keyword_mst: { keyword: @keyword_mst.keyword }
    end

    assert_redirected_to keyword_mst_path(assigns(:keyword_mst))
  end

  test "should show keyword_mst" do
    get :show, id: @keyword_mst
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keyword_mst
    assert_response :success
  end

  test "should update keyword_mst" do
    patch :update, id: @keyword_mst, keyword_mst: { keyword: @keyword_mst.keyword }
    assert_redirected_to keyword_mst_path(assigns(:keyword_mst))
  end

  test "should destroy keyword_mst" do
    assert_difference('KeywordMst.count', -1) do
      delete :destroy, id: @keyword_mst
    end

    assert_redirected_to keyword_msts_path
  end
end
