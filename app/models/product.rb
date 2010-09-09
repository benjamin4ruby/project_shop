# A Product in the catalogue

class Product < ActiveRecord::Base

  # === List of columns ===
  #   id          : integer 
  #   title       : string 
  #   description : text 
  #   published   : boolean 
  #   price       : decimal 
  #   image       : string 
  #   created_at  : datetime 
  #   updated_at  : datetime 
  #   category_id : integer 
  # =======================


  validates_presence_of :title, :description, :category_id
  validates_length_of :title, :minimum => 4
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  has_many :properties, :dependent => :destroy
  has_many :ordered_products
  belongs_to :category

  def self.search(search, price, price_comparator, category_id)

    puts '++++++++++++++++++++++++++++++++++++++++++++' + search
    puts price
    puts price_comparator
    puts category_id

    categories = Array.new
    search_condition = "%" + search + "%"

    if (category_id != '-1')

      categories.push(category_id)

      category = Category.find(:first, :conditions => ["id = ?", category_id])

      CategoriesHelper.find_sub_products(category, categories)

    end

    puts categories

    if ((category_id != '-1') && (!price.empty?) && (!search.empty?))

          find(:all, :conditions => ["title LIKE ? OR description LIKE ? AND price #{price_comparator} ? AND category_id IN (?)", search_condition, search_condition, price, categories])

    elsif ((category_id != '-1') && (!price.empty?) && (search.empty?))

          find(:all, :conditions => ["price #{price_comparator} ? AND category_id IN (?)", price, categories])

    elsif ((category_id != '-1') && (price.empty?) && (!search.empty?))

          find(:all, :conditions => ["title LIKE ? OR description LIKE ? AND category_id IN (?)", search_condition, search_condition, categories])

    elsif ((category_id != '-1') && (price.empty?) && (search.empty?))

          find(:all, :conditions => ["category_id IN (?)", categories])

    elsif ((category_id == '-1') && (!price.empty?) && (!search.empty?))

          find(:all, :conditions => ["title LIKE ? OR description LIKE ? AND price #{price_comparator} ?", search_condition, search_condition, price])

   elsif ((category_id == '-1') && (!price.empty?) && (search.empty?))

          find(:all, :conditions => ["price #{price_comparator} ?", price])

   elsif ((category_id == '-1') && (price.empty?) && (!search.empty?))

          find(:all, :conditions => ["title LIKE ? OR description LIKE ?", search_condition, search_condition])

    else
          find(:all)
    end
  end
    
  def to_s
    title
  end
  
  def inspect
    "#<#{to_s}: #{price} €>"
  end
end
