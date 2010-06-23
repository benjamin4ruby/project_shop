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
  
  def self.get_toplevel_categories
    #find()
  end
  
  def get_breadcrumbs
    _get_breadcrumbs
  end  
  
  def to_s
    title
  end
  
  def inspect
    "#<#{to_s}| Subcategories: #{sub_categories.map!(&:to_s).join(", ")}>"
  end
  
  # Sorting by id (for test)
  include Comparable
  def <=>(other)
    id <=> other.id
  end
  
  protected 
  #
  # Calculate all paths that lead to this category
  # in a recursive manner
  #
  # @param  Array(Category)        ancestors   Parents of this category.
  # @return Array(Array(Category)) Array of all found paths.
  def _get_breadcrumbs(ancestors = [])
    found = []
    ancestors.unshift self
puts ancestors.inspect
    
    # End of recursion: one possible way found
    return [ ancestors ] if super_categories.nil?
    
    super_categories.each do |super_category|
#      found += super_category._get_breadcrumbs(ancestors)
      return super_category._get_breadcrumbs(ancestors)
    end
    
    found
  end
end
