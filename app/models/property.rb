# A property of a product

class Property < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   key        : string 
  #   value      : string 
  #   product_id : integer 
  #   created_at : datetime 
  #   updated_at : datetime 
  # =======================

  belongs_to :product
  validates_presence_of :key, :value, :product_id
  
end
