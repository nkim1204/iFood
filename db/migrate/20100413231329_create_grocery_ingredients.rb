class CreateGroceryIngredients < ActiveRecord::Migration
  def self.up
    create_table :grocery_ingredients do |t|
      t.integer :user_id
      t.integer :ingredient_id
      t.float :qty
      t.string :unit
      t.timestamps
    end
  end

  def self.down
    drop_table :grocery_ingredients
  end
end
