# A property of a product

class Property < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :key, :value, :product_id
  
end
