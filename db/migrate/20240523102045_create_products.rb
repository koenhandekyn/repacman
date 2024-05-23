class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :weight, null: false, default: ""
      t.string :barcode, null: true
      t.integer :family_id, null: false
      t.integer :label_id, null: true
      t.integer :plant_id, null: false
      t.integer :bag_id, null: true

      t.timestamps

      t.index :code, unique: true
      t.index :barcode, unique: true
      t.index :family_id
      t.index :plant_id
      t.index :label_id
      t.index :bag_id
    end

    create_table :bags do |t|
      t.string :name, null: false

      t.timestamps

      t.index :name, unique: true
    end

    create_table :plants do |t|
      t.string :streetnr, null: false, default: ""
      t.string :zip, null: false, default: ""
      t.string :city, null: false, default: ""
      t.string :country, null: false, default: ""

      t.timestamps
    end

    create_table :labels do |t|
      t.string :nicelabel_name, null: false

      t.timestamps

      t.index :nicelabel_name, unique: true
    end

    create_table :families do |t|
      t.string :name, null: false
      t.text :composition, null: true
      t.text :components, null: true
      t.text :additives, null: true
      t.text :dosage, null: true
      t.text :claims, null: true
      t.text :instructions, null: true
      t.integer :tht_months, null: true
      t.string :manufacturer_code, null: false, default: ""

      t.timestamps

      t.index :name, unique: true
      t.index :manufacturer_code
    end
  end
end
