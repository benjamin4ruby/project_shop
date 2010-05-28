class Product < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_length_of :title, :minimum => 4
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  
  include ActionView::Helpers::NumberHelper

  def get_img
  	
  end
  
  def show_price
  	if price > 0
  	  number_to_currency price, :unit => "€", :separator => ','
  	else
  	  'FREE'
  	end
  end
end
