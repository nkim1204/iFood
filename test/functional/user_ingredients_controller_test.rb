require 'test_helper'

class UserIngredientsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_ingredients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_ingredient" do
    assert_difference('UserIngredient.count') do
      post :create, :user_ingredient => { }
    end

    assert_redirected_to user_ingredient_path(assigns(:user_ingredient))
  end

  test "should show user_ingredient" do
    get :show, :id => user_ingredients(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => user_ingredients(:one).to_param
    assert_response :success
  end

  test "should update user_ingredient" do
    put :update, :id => user_ingredients(:one).to_param, :user_ingredient => { }
    assert_redirected_to user_ingredient_path(assigns(:user_ingredient))
  end

  test "should destroy user_ingredient" do
    assert_difference('UserIngredient.count', -1) do
      delete :destroy, :id => user_ingredients(:one).to_param
    end

    assert_redirected_to user_ingredients_path
  end
end
