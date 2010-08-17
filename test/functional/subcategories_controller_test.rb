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
  
  test "should create subcategory association with XHR" do
    sub_cat = categories(:one)
    super_cat = categories(:two)  
    
    ret = ""
    assert_difference("Category.find(#{super_cat.id}).sub_categories.count", +1) do
      ret = xhr :put, :update, :id => super_cat.id, :other_id => sub_cat.id
    end
    assert_equal("200 OK", ret.status)
    assert("Insert into DOM", ret.body["Element.insert"])
  end

  test "should destroy subcategory association with XHR" do
    sub_cat = categories(:tshirts)
    super_cat = categories(:cloth)
    
    ret = ""
    assert_difference("Category.find(#{super_cat.id}).sub_categories.count", -1) do
      ret = xhr :delete, :destroy, :id => super_cat.id, :other_id => sub_cat.id
      assert_equal(nil, flash[:error])
    end
    assert_equal("200 OK", ret.status)
    assert("Remove from DOM", ret.body["Element.remove"])

  end
  
end
