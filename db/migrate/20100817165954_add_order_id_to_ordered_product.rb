class AddOrderIdToOrderedProduct < ActiveRecord::Migration
  def self.up
    add_column :ordered_products, :order_id, :integer
  end

  def self.down
    remove_column :ordered_products, :order_id
  end
end
