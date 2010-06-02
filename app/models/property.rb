# A property of a product

class Property < ActiveRecord::Base
  # Only needed for back-reference Property->Product
  belongs_to :product
  validates_presence_of :key, :value
  
end
