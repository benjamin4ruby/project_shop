class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  def index
    #Reserved for admin use only, shows 
    @orders = Order.find(:all, :conditions => [ "user_id = ? AND status > 1", session[:user].id ])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end
  
  def showShoppingCard
    @order = session[:order]
    render :show do
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end
  
  def createOrderedProduct
    product = Product.find(params[:product_id])
    orderedProduct = OrderedProduct.find(:first, :conditions => { :order_id => @order.id, :product_id => product.id })
    
    if orderedProduct
      orderedProduct.quantity += 1
    else 
      orderedProduct = OrderedProduct.new()
      orderedProduct.order_id = @order.id
      orderedProduct.product_id = product.id
      orderedProduct.unit_price = product.price
      orderedProduct.quantity = 1
    end
    @order.price += product.price * 1
    orderedProduct.save
    return orderedProduct.id
  end
  
  def addProductToShoppingCart
    if session[:order] == nil
      @order = Order.create
      @order.user_id = session[:user].id
    else
      @order = session[:order]
    end
    self.createOrderedProduct
    @order.save
    session[:order] = @order
  end
  
  def removeProduct
     productToRemove = OrderedProduct.find(:first, :conditions => { :order_id => session[:order].id, :product_id => params[:product_id] })
     OrderedProduct.delete(productToRemove)
     orderToUpdate = Order.find(:first, :conditions => { :id => session[:order].id }) 
     orderToUpdate.ordered_products.delete(productToRemove)
     orderToUpdate.price -= productToRemove.unit_price * productToRemove.quantity
     orderToUpdate.save
     session[:order] = orderToUpdate
     
     render :update do |page|
       if params[:locale] == "en"
         page.replace_html 'shoppingCartText', "The product: " + 
                                                      Product.find(params[:product_id]).title + 
                                                      " has been removed to your shopping cart !"
       else
         page.replace_html 'shoppingCartText', "Le produit: " + 
                                                      Product.find(params[:product_id]).title + 
                                                      " a été retiré de votre panier !"
       end                                               
       page.toggle 'shopingCartBg'
       page.toggle 'shoppingCartNotification'
       page.reload
     end
  end
  
  def showShoppingCartNotification
    render :update do |page|
      if params[:locale] == "en"
        page.replace_html 'shoppingCartText', "The product: " + 
                                                     Product.find(params[:product_id]).title + 
                                                     " has been added to your shopping cart !"
      else
        page.replace_html 'shoppingCartText', "Le produit: " + 
                                                     Product.find(params[:product_id]).title + 
                                                     " a été ajouté à votre panier !"
      end                                               
      page.toggle 'shopingCartBg'
      page.toggle 'shoppingCartNotification'
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    if (params[:product_id])
      self.addProductToShoppingCart
      self.showShoppingCartNotification
    else
      respond_to do |format|
        if @order.save
          flash[:notice] = 'Order was successfully created.'
          format.html { redirect_to(@order) }
          format.xml  { render :xml => @order, :status => :created, :location => @order }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
    if @order.status > 1
      self.email_sent((User.find(@order.user_id)).email, @order.id)
    end
  end
  
  def email_sent(recipients_email,order_id)
    ShopMailer::deliver_mail(recipients_email,order_id)   
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
