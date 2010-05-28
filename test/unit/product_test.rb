require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products
  
  # Replace this with your real tests.
  test "free product should be allowed" do 
    assert products(:free).valid?, products(:free).errors.inspect
  end
  
  test "free should show free as price" do
    assert_equal 'FREE', products(:free).show_price
  end
  
  test "price format" do
    assert products(:for10euros01).valid?
    assert_equal '€10,01', products(:for10euros01).show_price
  end

end
