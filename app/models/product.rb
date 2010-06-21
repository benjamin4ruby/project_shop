# A Product in the catalogue

class Product < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_length_of :title, :minimum => 4
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  has_many :properties, :dependent => :destroy
  
  def get_img
  	
  end
  
end
