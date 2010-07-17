class Category < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   title      : string 
  #   created_at : datetime 
  #   updated_at : datetime 
  # =======================

  validates_presence_of :title

  has_and_belongs_to_many :sub_categories, :class_name => "Category", :foreign_key => "super_category_id", :association_foreign_key => 'sub_category_id', :before_add => :validate_add_sub_category
  has_and_belongs_to_many :super_categories, :class_name => "Category", :foreign_key => "sub_category_id", :association_foreign_key => 'super_category_id', :before_add => :validate_add_super_category, :after_add => :invalidate_sub_category_cache
  
  has_many :products
  
  def validate_add_sub_category(sub_category)
    raise ActiveRecord::AssociationTypeMismatch, "The category cannot be associated to itself", caller if sub_category == self
    raise ActiveRecord::AssociationTypeMismatch, "The category cannot be added: a parent category cannot be subcategory at the same time.", caller if descendant_of? sub_category
    raise ActiveRecord::AssociationTypeMismatch, "The category cannot be added: a parent category cannot be subcategory at the same time.", caller if ancestor_of? sub_category
  end
   
  def validate_add_super_category(super_category)
    super_category.validate_add_sub_category self
  end

  # Invalidation because of ancestor_of?  
  def invalidate_sub_category_cache(other)
    self.sub_categories(true)
    other.sub_categories(true)
  end
  
  # Distant relationship checks
  def ancestor_of?(other)
#puts "Am I #{self} ancestor of #{other}?"

    # Traverse categories from self to bottom until other is found.
    #
    # Not very performant, but categories shouldn't be too nested anyway.
    #
    # Possible Amelioriations:
    # * SQL Self-joins?
    # * Nested model? Maybe a plugin exists?

    subs = sub_categories
    if subs.empty?
      false          # Reached the end of the tree, so continue recursion elsewhere
    elsif subs.include? other
      true           # Found, so back out of the recursion
    else
      subs.any? { |cat| cat.ancestor_of? other } # Tree continues
    end
  end
  
  def descendant_of?(other)
    other.ancestor_of? self
  end
  
  def relative_of?(other)
    self == other || ancestor_of?(other) || descendant_of?(other)
  end
  
  def self.find_toplevel_categories
    all :conditions => "id NOT IN (SELECT sub_category_id FROM categories_categories)"
  end
  
  def get_breadcrumbs
    _get_breadcrumbs []
  end  
  
  def to_s
    title
  end
  
  def inspect
    "#<#{to_s}| Subcategories: #{sub_categories.map(&:to_s).join(", ")}>"
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
  def _get_breadcrumbs(ancestors)
    found = []
    ancestors = ancestors.clone.unshift self
    
    # End of recursion: one possible way found
    return [ ancestors ] if super_categories.empty?
    
    super_categories.each do |super_category|
      found += super_category._get_breadcrumbs(ancestors)
    end
    
    found
  end
end
