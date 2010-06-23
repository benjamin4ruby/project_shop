# To run all unit tests: 
# rake test:units

require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  include ActionView::Helpers::NumberHelper
  include ProductsHelper
   
  test "free should show free as price" do
    free_product = TestFactory.create_product :price => 0
    
    I18n.locale = :en
    assert_equal I18n.t(:FREE), show_currency(free_product.price)
    I18n.locale = :fr
    assert_equal I18n.t(:FREE), show_currency(free_product.price)
  end
  
  test "price format" do
    p = TestFactory.create_product :price => 10.01
    
    # Freaking space! number_to_currency seems to translate " " in some non-breaking unicode equivalency. Too magic ...
    I18n.locale = :en
    assert show_currency(p.price)["10.01"]
    I18n.locale = :fr
    assert show_currency(p.price)["10,01"]
  end
  
  test "big price format" do
    p = TestFactory.create_product :price => 1000.01
    
    I18n.locale = :en
    assert show_currency(p.price)["1,000.01"], show_currency(p.price)
    I18n.locale = :fr
    assert show_currency(p.price)["000,01"], show_currency(p.price)
  end

  test "no negative price allowed" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_product :price => -0.01  
    end
  end

  test "title must have minimum 4 characters" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_product :title => 'foo'
    end
  end

  test "description must not be empty" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_product :description => ''
    end
  end

  test "description must not be nil" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_product :description => nil
    end
  end

end
