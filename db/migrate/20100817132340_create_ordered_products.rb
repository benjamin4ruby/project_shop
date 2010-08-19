class CreateOrderedProducts < ActiveRecord::Migration
  def self.up
    create_table :ordered_products do |t|
      t.integer :product_id
      t.integer :quantity
      t.float :unit_price

      t.timestamps
    end
  end

  def self.down
    drop_table :ordered_products
  end
end
