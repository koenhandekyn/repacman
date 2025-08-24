class AddStatusToBatches < ActiveRecord::Migration[7.2]
  def up
    execute <<~SQL
              ALTER TABLE batches
              ADD COLUMN status ENUM('pending','completed')
              NOT NULL DEFAULT 'pending'
            SQL
  end

  def down
    remove_column :batches, :status
  end
end
