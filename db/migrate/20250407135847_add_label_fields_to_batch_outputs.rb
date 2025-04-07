class AddLabelFieldsToBatchOutputs < ActiveRecord::Migration[7.2]
  def change
    add_column :batch_outputs, :xml_exported_at, :datetime, null: true
    add_column :batch_outputs, :best_before_date, :datetime, null: true
  end
end
