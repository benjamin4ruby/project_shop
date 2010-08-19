class Order < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   user_id    : integer 
  #   price      : float 
  #   status     : integer 
  #   created_at : datetime 
  #   updated_at : datetime 
  # =======================

  has_many :ordered_products

  def getStatusAsString
    case status  
       when 1
         return :status_in_shopping_cart
       when 2
         return :status_ordered
       when 3 
         return :status_shipped
       else return "Lost somewhere in the world"
     end
  end

end
