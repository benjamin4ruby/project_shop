module CategoriesHelper
  CATEGORY_INDENT = '- '
  
  def select_categories_tag(name, selected = nil, toplevel = nil)
    if toplevel.kind_of? Category
      cats = toplevel.sub_categories
    else
      cats = Category.find_toplevel_categories
    end
    
    return I18n.t("NoCategoriesFound") if cats.empty?
    
    if params[name]
      selected ||= {}
      selected[:selected] = params[name]
    end
    # Easier, but can't indent the title to show sub-categories:
    # select_tag name, options_from_collection_for_select(cats, :id, :title, selected)
    
    select_tag name, options_for_select(category_options(cats), selected)
  end
  
  def category_options(cats, indent = "")
    return [] if cats.empty?
puts "ja" + indent
    
    options = []
    cats.each do |c|
puts "#{c.inspect}"
      options << category_option(c, indent)
      options += category_options(c.sub_categories, indent + CATEGORY_INDENT)
    end
    
    options
  end
  
  def category_option(cat, indent)
#    return nil if cat.title.nil?
    [indent + '' + cat.title, cat.id]
  end
  
end
