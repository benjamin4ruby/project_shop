class CreateSubCategoriesSuperCategories < ActiveRecord::Migration
  def self.up
    create_table :categories_categories, :id => false do |t|
      t.integer :super_category_id
      t.integer :sub_category_id
    end
  end

  def self.down
    drop_table :categories_categories
  end
end