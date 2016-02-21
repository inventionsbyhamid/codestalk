require 'test_helper'

class CodechefIdsControllerTest < ActionController::TestCase
  setup do
    @codechef_id = codechef_ids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:codechef_ids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create codechef_id" do
    assert_difference('CodechefId.count') do
      post :create, codechef_id: { user_id: @codechef_id.user_id, username: @codechef_id.username }
    end

    assert_redirected_to codechef_id_path(assigns(:codechef_id))
  end

  test "should show codechef_id" do
    get :show, id: @codechef_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @codechef_id
    assert_response :success
  end

  test "should update codechef_id" do
    patch :update, id: @codechef_id, codechef_id: { user_id: @codechef_id.user_id, username: @codechef_id.username }
    assert_redirected_to codechef_id_path(assigns(:codechef_id))
  end

  test "should destroy codechef_id" do
    assert_difference('CodechefId.count', -1) do
      delete :destroy, id: @codechef_id
    end

    assert_redirected_to codechef_ids_path
  end
end
