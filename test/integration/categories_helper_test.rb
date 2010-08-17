# Run: rake test:integration
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CategoriesHelperTest < ActiveSupport::TestCase
  include CategoriesHelper

  # Test disabled_options  
  test "No options are disabled" do
    assert_equal [], disabled_options((1..10).to_a) { true }
  end
  
  test "All options are disabled" do
    c = TestFactory.create_categories 5
    assert_equal c.pluck(:id), disabled_options(c) { false }  
  end
  
  test "First 2 options are disabled" do
    c = TestFactory.create_categories 5
    cat_enabled = c[2..4]
    cat_disabled = c - cat_enabled

    assert_equal cat_disabled.pluck(:id), disabled_options(c) { |c| cat_enabled.include? c }  
  end

  test "First 2 options are enabled" do
    c = TestFactory.create_categories 5
    cat_enabled = c[0..1]
    cat_disabled = c - cat_enabled 

    assert_equal cat_disabled.pluck(:id), disabled_options(c) { |c| cat_enabled.include? c }  
  end
  
  test "Random options disabled" do
    c = TestFactory.create_categories 10
    cat_enabled = c.values_at(0, 1, 5, 9)
    cat_disabled = c - cat_enabled 

    assert_equal cat_disabled.pluck(:id), disabled_options(c) { |c| cat_enabled.include? c }    
  end
end
