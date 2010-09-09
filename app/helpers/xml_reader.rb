# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rexml/document'
include REXML

module XMLReader

  def XMLReader.delete_all
    Product.destroy_all()
    Category.destroy_all()
  end

  def XMLReader.read_xml (fileName)

    file = File.new(fileName)
    doc = Document.new(file)
    root = doc.root
    
    categorieslist = root.elements["CategoriesList"]

    categorieslist.each_element('Category') do |xmlCategory|

        name = xmlCategory.elements['name'].text.strip
        puts name
        Category.create(:title => name)

    end

    categorieslist.each_element('Category') do |xmlCategory|

      if (!xmlCategory.elements['SubCategories'].blank?)
        
        subCategories = xmlCategory.elements['SubCategories']

        if (!subCategories.elements['SubCategory'].blank?)

          subCategories.each_element('SubCategory') do |xmlSubCategory|

            puts 'gfgfgfggggfgfgf' + xmlCategory.elements['name'].text
            puts 'aaaaaaaaaaaaaaa' + xmlSubCategory.text.strip

            cat = Category.find(:first, :conditions => ["title = ?", xmlCategory.elements['name'].text.strip])
            subCat = Category.find(:first, :conditions => ["title = ?", xmlSubCategory.text.strip])
            
            puts 'CAT ID4 ' + cat.title.to_s
            puts 'SUB_CAT ' + subCat.title.to_s

            begin

            cat.sub_categories << subCat

            rescue ActiveRecord::RecordNotFound
                 puts 'boom HeadShotttttt1' #flash[:error] = t(:error_category_doesnt_exist)
            rescue ActiveRecord::AssociationTypeMismatch
                 puts 'boom HeadShotttttt2' #flash[:error] = t(:error_category_assoc_impossible)

            end
         end
       end
      end
    end

    productslist = root.elements["ProductsList"]

    productslist.each_element('Product') do |xmlProduct|

        description = xmlProduct.elements['description'].text.strip
        category_name = xmlProduct.elements['category'].text.strip
        title = xmlProduct.elements['title'].text.strip

        category = Category.find(:first, :conditions => ['title = ?', category_name])

        @product = Product.create(:description => description, :category_id => category.id, :title => title)

        if (!xmlProduct.elements['property'].blank?)

            xmlProduct.each_element('property') do |xmlProperty|

            property = xmlProperty.attributes['name'].strip
            value = xmlProperty.text.strip

            case property

                when 'price'
                    @product.update_attributes(:price => value)

                when 'image'
                    @product.update_attributes(:image => value)

                when 'published'
                    @product.update_attributes(:published => value)

                else
                    puts 'property unknown'
            end
           end
         end
      end
   end

end



  

