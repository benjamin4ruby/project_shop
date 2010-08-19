module SubcategoriesControllerHelper

  def category_association_id(id, other_id)
    "cat_assoc_#{id.to_i}_#{other_id.to_i}"
  end
  
  def select_new_subcategory_id
    'select_new_subcategory'
  end
  
  def select_new_subcategory_tag(name, category, id = nil)
    id ||= select_new_subcategory_id
    select_categories_tag(name, nil, nil, {:id => id}) { |c| !c.relative_of?(category) }
  end

  SUBCATEGORIES_SPACER = "&nbsp;&nbsp;"
  
  def show_subcategories(sub_categories)
    return '' if sub_categories.count == 0
    
    str = I18n.t 'nSubcategories', :count => sub_categories.count
    str << ': '
    str << sub_categories.map do |sub|
      link_to h(sub), sub
    end.join(SUBCATEGORIES_SPACER)
  end

end
