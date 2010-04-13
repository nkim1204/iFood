class CreateUnitConversions < ActiveRecord::Migration
  def self.up
    create_table :unit_conversions do |t|
      t.string :from
      t.string :to
      t.float :ratio
      t.integer :category
    end
  end

  def self.down
    drop_table :unit_conversions
  end
end
