# A Product in the catalogue

class Product < ActiveRecord::Base

  # === List of columns ===
  #   id          : integer 
  #   title       : string 
  #   description : text 
  #   published   : boolean 
  #   price       : decimal 
  #   image       : string 
  #   created_at  : datetime 
  #   updated_at  : datetime 
  # =======================

  validates_presence_of :title, :description
  validates_length_of :title, :minimum => 4
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  has_many :properties, :dependent => :destroy
  
  # For security-related attributes, use:
  # attr_accessible :name
  
  def get_img
  	
  end
  
end
