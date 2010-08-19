class OrderedProduct < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   product_id : integer 
  #   quantity   : integer 
  #   unit_price : float 
  #   created_at : datetime 
  #   updated_at : datetime 
  #   order_id   : integer 
  # =======================

belongs_to :product
belongs_to :order

end


