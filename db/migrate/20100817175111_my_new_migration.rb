class MyNewMigration < ActiveRecord::Migration
  def self.up
      change_column :orders, :price, :float, :default => 0
      change_column :ordered_products, :unit_price, :float, :default => 0
      change_column :orders, :status, :integer, :default => 1
  end

  def self.down
  end
end
