# Run rake test:functionals
require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, :category => { :title => 'test' }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, :id => categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categories(:one).to_param
    assert_response :success
  end

  test "should update category" do
    put :update, :id => categories(:one).to_param, :category => { }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should not destroy category" do
    assert_raise ActionController::RoutingError do
      delete :destroy, :id => categories(:one).to_param
    end
  end
end
