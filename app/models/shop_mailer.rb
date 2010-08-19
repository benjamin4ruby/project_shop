class ShopMailer < ActionMailer::Base
  
  def mail(recipient, order_id)   
    from 'no-reply@rubyProjectShop.com'   
    recipients recipient    
    subject "Order status update -- Ruby Project Shop"    
    body(:recipient => recipient, :order_id => order_id)   
  end

end
