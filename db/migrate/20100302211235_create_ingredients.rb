class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.string :name
      t.integer :ingredient_category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
