class AddNameToPlant < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :name, :string
    add_index :plants, :name
  end
end
