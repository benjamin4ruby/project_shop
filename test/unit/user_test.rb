require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class UserTest < ActiveSupport::TestCase
  
  #validates_presence_of :name, :forename, :address, :zip, :city, :country, :password
  #validates_length_of :password, :minimum => 8, :too_short => "please enter at least 8 character"
  #validates_confirmation_of :password, :message =>"Password confirmation should match with the first password"
  
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Your email address appears not to be valid"
  #validates_uniqueness_of :email, :message => "A user with this password already exists"
  
  test "name must not be nil" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_user :name => nil
    end
  end
  test "forename must not be nil" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_user :forename => nil
    end
  end
  test "address must not be nil" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_user :address => nil
    end
  end
  test "zip must not be nil" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_user :zip => nil
    end
  end
  test "city must not be nil" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_user :city => nil
    end
  end
  test "password must not be nil" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_user :password => nil
    end
  end
  test "password should be greater than 7" do
    assert_raise ActiveRecord::RecordInvalid do 
      TestFactory.create_user :password => "dorian"
    end
  end

end
