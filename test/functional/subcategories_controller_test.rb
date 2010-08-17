require 'test_helper'

class SubcategoriesControllerTest < ActionController::TestCase
  
  test "should get edit" do
    get :edit, :id => categories(:one).id
    assert_response :success
  end

  test "should create subcategory association" do
    sub_cat = categories(:one)
    super_cat = categories(:two)  
    
    assert_difference("Category.find(#{super_cat.id}).sub_categories.count", +1) do
      put :update, :id => super_cat.id, :other_id => sub_cat.id
    end
    assert_redirected_to edit_category_path(assigns(:product))
  end

  test "should destroy subcategory association" do
    sub_cat = categories(:socks)
    super_cat = categories(:cloth)
    
    assert_difference("Category.find(#{super_cat.id}).sub_categories.count", -1) do
      delete :destroy, :id => super_cat.id, :other_id => sub_cat.id
    end

    assert_redirected_to edit_category_path(super_cat)
  end
end
