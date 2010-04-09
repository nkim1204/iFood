class AddDeltaIndex < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :delta, :boolean, :default => true, :null => false
    add_column :recipes, :delta, :boolean, :default => true, :null => false
    add_column :recipe_ingredients, :delta, :boolean, :default => true, :null => false
    add_column :user_ingredients, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :ingredients, :delta
    remove_column :recipes, :delta
    remove_column :recipe_ingredients, :delta
    remove_column :user_ingredients, :delta
  end
end
