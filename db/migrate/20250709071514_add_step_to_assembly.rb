class AddStepToAssembly < ActiveRecord::Migration[7.2]
  def change
    add_column :assemblies, :step, :string
  end
end
