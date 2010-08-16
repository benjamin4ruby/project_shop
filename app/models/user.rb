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
  #   phone      : string 
  #   isAdmin    : boolean 
  # =======================

  validates_presence_of :name, :forename, :address, :zip, :city, :country, :password
  validates_length_of :password, :minimum => 8, :too_short => "please enter at least 8 character"
  validates_confirmation_of :password, :message =>"Password confirmation should match with the first password"
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Your email address appears not to be valid"
  validates_uniqueness_of :email, :message => "A user with this password already exists"
  
  def to_s
    email
  end
  
  def inspect
    "#<#{to_s}: #{name},#{forename}>"
  end
  
end
