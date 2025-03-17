class CreateProductionProducts < ActiveRecord::Migration[7.1]
  def change

    # business question: why change the batch id when repackaging?
    # batch number uniformity

    # 1
    create_table :assemblies do |t|
      t.integer :parent_family_id, null: false
      t.integer :child_family_id, null: false
      t.string :weight, null: false, default: ""

      t.timestamps
    end
    # Add index to parent_id
    add_index :assemblies, :parent_family_id
    # Add index to child_id
    add_index :assemblies, :child_family_id

    # 2
    create_table :batches do |t|
      t.datetime :produced_at, null: false
      t.string :batch_uid, null: false, default: ""
      t.integer :family_id, null: false
      t.string :weight, null: false, default: ""

      t.timestamps
    end
    # Add index to product_id
    add_index :batches, :family_id
    # Add index to batch
    add_index :batches, :batch_uid, unique: true

    # 3
    # This is about tracking the ingredients of a batch
    # What stock items are used to create a batch (decreases stock)
    create_table :batch_inputs do |t|
      t.integer :batch_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, null: false, default: 1
      t.string :batch_uid, null: false, default: ""

      t.timestamps
    end
    # Add index to batch_id
    add_index :batch_inputs, :batch_id

    # 4
    # This is about tracking the packagings of a batch, that result in products
    # What stock items are created from a batch (increases stock)
    create_table :batch_outputs do |t|
      t.integer :batch_id, null: false   # batch family varkensbrokken (100kg)
      t.integer :product_id, null: false  # zakken van 10kg (10x)
      t.integer :quantity, null: false, default: 1 # 10kg
      t.string :batch_uid, null: false, default: "" # batch number (inherit from the batch, but editable?)

      # TODO maybe a view table for printing labels

      t.timestamps
    end
    # Add index to batch_id
    add_index :batch_outputs, :batch_id

    # TODO: Append weight to the existing Bags table
    add_column :bags, :weight, :string
  end
end
