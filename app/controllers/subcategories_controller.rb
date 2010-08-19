class SubcategoriesController < ApplicationController

  # POST /subcategories/17/edit
  def edit
    @category = Category.find(params[:id])
  end
  
  
  # PUT /subcategories/17 {id of the top category}
  def update
    begin
      @category = Category.find(params[:id])
      @other_category = Category.find(params[:other_id])    
      
      @category.sub_categories << @other_category
    rescue ActiveRecord::RecordNotFound
        flash[:error] = t(:error_category_doesnt_exist)
    rescue ActiveRecord::AssociationTypeMismatch
        flash[:error] = t(:error_category_assoc_impossible)    
    end

    respond_to do |format|
      format.html { redirect_to edit_category_path(@category) }
      format.js # Doesn't render
    end
  end


  # DELETE /subcategories/17/34 {id of top category} / {id of sub category}
  def destroy
    begin
      @category = Category.find(params[:id])
      @other_category = Category.find(params[:other_id])
      
      if (@category.sub_categories.include?(@other_category))
        @category.sub_categories -= [@other_category]
      elsif (@category.super_categories.include?(@other_category))
        @category.super_categories -= [@other_category]
      else
        flash[:error] = t(:error_category_association_not_found)
      end
    rescue ActiveRecord::RecordNotFound
        flash[:error] = t(:error_category_doesnt_exist)
    end

    respond_to do |format|
      format.html { redirect_to edit_category_path(@category) }
      format.js
    end
  end
end
