class ChangeQuantityToDecimalInBatchOutputs < ActiveRecord::Migration[7.2]
  def change
    change_column :batch_outputs, :quantity, :decimal, precision: 10, scale: 3, default: 1.0, null: false
  end
end
