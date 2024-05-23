class CreateNiceLabelReprintView < ActiveRecord::Migration[7.1]
  def change
    def up
      execute <<-SQL
        CREATE VIEW nicelabel_reprint
        AS
        SELECT
          Printed.Batch as batch,
          Printed.CreatedAt as created_at,
          Printed.BestBeforeDate as best_before_date,
          products.*,
          bags.name as bag_name,
          labels.nicelabel_name as label_name,
          families.name as family_name,
          families.composition,
          families.components,
          families.additives,
          families.dosage,
          families.claims,
          families.instructions,
          families.tht_months,
          families.manufacturer_code,
          families.bio
        FROM Printed
        JOIN products ON Printed.ItemCode = products.code
        LEFT JOIN bags ON products.bag_id = bags.id
        LEFT JOIN plants ON products.plant_id = plants.id
        LEFT JOIN labels ON products.label_id = labels.id
        LEFT JOIN families ON products.family_id = families.id
        ORDER BY Printed.CreatedAt DESC;

      SQL
    end

    def down
      execute <<-SQL
        DROP VIEW IF EXISTS nicelabel_reprint;
      SQL
    end
    end
end
