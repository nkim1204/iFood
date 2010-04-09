class AddServingQty < ActiveRecord::Migration
  def self.up
     add_column :recipes, :serving_qty, :integer, :default => 1
  end

  def self.down
     remove_column :recipes, :serving_qty
  end
end
