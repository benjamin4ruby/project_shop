class Category < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   title      : string 
  #   created_at : datetime 
  #   updated_at : datetime 
  # =======================

  has_and_belongs_to_many :sub_categories, :class_name => "Category", :foreign_key => "sub_category_id", :association_foreign_key => 'super_category_id'
  has_and_belongs_to_many :super_categories, :class_name => "Category", :foreign_key => "super_category_id", :association_foreign_key => 'sub_category_id'
  
  has_many :products
end
