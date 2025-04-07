class CreateViewProductionLabels < ActiveRecord::Migration[7.2]
  def up
    execute <<-SQL
      CREATE VIEW production_labels AS
      SELECT
        batch_outputs.id,
        batch_outputs.batch_id,
        batch_outputs.product_id,
        batch_outputs.quantity,
        batch_outputs.batch_uid as output_batch_uid,
        batch_outputs.xml_exported_at,
        batch_outputs.label_printed_at,
        batches.produced_at,
        batches.batch_uid as batch_uid,
        batches.weight as batch_weight,
        batches.best_before_date,
        products.code,
        products.weight as product_weight,
        products.barcode,
        products.label_id,
        products.plant_id,
        products.bag_id,
        families.name,
        families.manufacturer_code,
        families.bio,
        families.is_batch,
        families.composition,
        families.components,
        families.additives,
        families.dosage,
        families.tht_months,
        families.claims,
        families.instructions
      FROM batch_outputs
      LEFT JOIN batches ON batch_outputs.batch_id = batches.id
      LEFT JOIN products ON batch_outputs.product_id = products.id
      LEFT JOIN families ON products.family_id = families.id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS production_labels
    SQL
  end
end


#   # t.integer :batch_id, null: false   # batch family varkensbrokken (100kg)
#   # t.integer :product_id, null: false  # zakken van 10kg (10x)
#   # t.integer :quantity, null: false, default: 1 # 10kg
#   # t.string :batch_uid, null: false, default: "" # batch number (inherit from the batch, but editable?)
#   add_column :batch_outputs, :xml_exported_at, :datetime, null: true
#   add_column :batch_outputs, :best_before_date, :datetime, null: true

#   create_table "batches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
#     t.datetime "produced_at", null: false
#     t.string "batch_uid", default: "", null: false
#     t.integer "family_id", null: false
#     t.string "weight", default: "", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["batch_uid"], name: "index_batches_on_batch_uid", unique: true
#     t.index ["family_id"], name: "index_batches_on_family_id"
#   end

#   create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
#     t.string "code", null: false
#     t.string "weight", default: "", null: false
#     t.string "barcode"
#     t.integer "family_id", null: false
#     t.integer "label_id"
#     t.integer "plant_id", null: false
#     t.integer "bag_id"
#     t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
#     t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
#     t.boolean "is_active", default: true
#     t.boolean "print_label_repack"
#     t.string "label_background_url"
#     t.index ["bag_id"], name: "index_products_on_bag_id"
#     t.index ["barcode"], name: "index_products_on_barcode", unique: true
#     t.index ["code"], name: "index_products_on_code", unique: true
#     t.index ["family_id"], name: "index_products_on_family_id"
#     t.index ["label_id"], name: "index_products_on_label_id"
#     t.index ["plant_id"], name: "index_products_on_plant_id"
#   end

#   create_table "families", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
#     t.string "name", null: false
#     t.text "composition"
#     t.text "components"
#     t.text "additives"
#     t.text "dosage"
#     t.text "claims"
#     t.text "instructions"
#     t.integer "tht_months"
#     t.string "manufacturer_code", default: "", null: false
#     t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
#     t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
#     t.boolean "bio", default: true
#     t.boolean "is_batch"
#     t.index ["bio"], name: "index_families_on_bio"
#     t.index ["manufacturer_code"], name: "index_families_on_manufacturer_code"
#     t.index ["name"], name: "index_families_on_name", unique: true
#   end
# end
