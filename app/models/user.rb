class User < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   name       : string 
  #   forename   : string 
  #   email      : string 
  #   address    : string 
  #   zip        : string 
  #   city       : string 
  #   country    : string 
  #   password   : string 
  #   created_at : datetime 
  #   updated_at : datetime 
  #   isAdmin    : boolean 
  #   phone      : string 
  # =======================

  validates_presence_of :name, :forename, :address, :zip, :city, :country, :password
  validates_length_of :hidden_password, :minimum => 8, :too_short => "please enter at least 8 character"
  validates_confirmation_of :hidden_password, :message =>"Password confirmation should match with the first password"
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Your email address appears not to be valid"
  validates_uniqueness_of :email, :message => "A user with this password already exists"

  def password=(value)
    self[:password] = PasswordHelper::update(value)
  end

  def hidden_password
    self[:hidden_password]
  end

  def hidden_password=(value)
    self[:hidden_password] = value
  end

  def to_s
    name + " " + forename + ": " + email
  end
  
  def inspect
    "#<#{to_s}>"
  end
  
  def isGuest
    return id == 1
  end
  
end
