module ProductsHelper
#RDoc commentare .... nicht so wichtig.

  SRC_IMAGE_MISSING = "/images/img_missing.png"
  TITLE_IMAGE_MISSING = "(Sorry, no image available)"
  
  def show_currency(price)
  	if price > 0
  	  number_to_currency price
  	else
  	  I18n.t 'FREE'
  	end
  end
  
  def show_image(product)
    if product && product.image && !product.image.empty?
      image_tag src_image(product.image), :title => product.title
    else
      image_tag SRC_IMAGE_MISSING, :title => TITLE_IMAGE_MISSING
    end
  end
  
  def src_image(img)
    if img && !img.empty?
      "/images/#{img}"
    else
      SRC_IMAGE_MISSING
    end
  end
  
  def file_image(img)
    Rails.root.to_s + "/public" + src_image(img)
  end
  
  def imagefile_exists?(img)
    File.exist? file_image(img)
  end
  
  def show_product_breadcrumbs(product)
    show_breadcrumbs(product.category, product.title)
  end

end
