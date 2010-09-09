# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rexml/document'
include REXML

module XMLWriter

  def XMLWriter.write_xml

    doc2 = Document.new
    doc2.add_element("parameters")

    root = doc2.root

    root.add_element("ProductsList")

    @products = Product.find(:all)

    @products.each do |dbProduct|

      xmlProduct = Element.new('Product')

      xmlProduct.add_element('title')
      xmlProduct.elements['title'].text = dbProduct.title

      xmlProduct.add_element('description')
      xmlProduct.elements['description'].text = dbProduct.description

      @category = Category.find(:first, :conditions => ['id = ?', dbProduct.category_id])

      xmlProduct.add_element('category')
      xmlProduct.elements['category'].text = @category.title

      if (!(dbProduct.price).blank?)

          property = Element.new('property')
          property.add_attribute('name', 'price')
          property.text = dbProduct.price

          xmlProduct.elements << property
      end

      if (!(dbProduct.image).blank?)

          property = Element.new('property')
          property.add_attribute('name', 'image')
          property.text = dbProduct.image

          xmlProduct.elements << property
      end
      
      if (!(dbProduct.published).blank?)

          property = Element.new('property')
          property.add_attribute('name', 'published')
          property.text = dbProduct.published

          xmlProduct.elements << property
      end



      root.elements['ProductsList'] << xmlProduct

    end

    root.add_element("CategoriesList")

    @categories = Category.find(:all)

    @categories.each do |dbCategory|

      xmlCategory = Element.new('Category')

      xmlCategory.add_element('name')
      xmlCategory.elements['name'].text = dbCategory.title

      @xmlSubCategories = Element.new('SubCategories')

      if (!(dbCategory.sub_categories).blank?)

          sub_cats = dbCategory.sub_categories

          sub_cats.each do |dbSubCategory|

          xmlSubCategory = Element.new('SubCategory')
          xmlSubCategory.text = dbSubCategory.title

          @xmlSubCategories.elements << xmlSubCategory

          #seek_sub_categories(dbSubCategory)

          end

      xmlCategory.elements << @xmlSubCategories
      end

      root.elements['CategoriesList'] << xmlCategory

    end

    return doc2

  end

  #save_to_file('market.xml', doc2)


  def XMLWriter.seek_sub_categories (category)

    if !(category.sub_categories).blank?

      sub_cats = category.sub_categories

      sub_cats.each do |dbSubCategory|

         xmlSubCategory = Element.new('SubCategory')
         xmlSubCategory.text = dbSubCategory.title

         @xmlSubCategories.elements << xmlSubCategory

      end
    end
  end

  def XMLWriter.save_to_file(fileName, document)

    puts document

    begin
      my_file = File.new(fileName)
    rescue
    end

    my_file = File.open(fileName, 'w')
    document.write(my_file, 4)
    my_file.close
  end

end
