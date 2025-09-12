# README

Bio-Ron RePacMan

# fetch db to local

    mysql -e "CREATE DATABASE bioron_packageup;"
    rm remote_dump.sql
    mysqldump -h eek.h.filess.io -u bioron_packageup -p --no-tablespaces bioron_packageup > remote_dump.sql
      passowrd: 2617875f38b61b926b6dad806ab466a90f791d6b
    mysql bioron_packageup < remote_dump.sql

second variant

    mysqldump --no-tablespaces -h eek.h.filess.io -u bioron_packageup -p --port=3306 bioron_packageup > remote_dump.sql
    # create tables
    mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS bioron_packageup_local;"
    mysql -u root -p bioron_packageup_local < remote_dump.sql


----

  create_table "Printed", id: :integer, charset: "utf16", collation: "utf16_unicode_ci", force: :cascade do |t|
    t.string "NicelabelId", limit: 12
    t.string "RepackDate"
    t.string "ItemCode", null: false
    t.integer "WarehouseCode", null: false
    t.integer "PlannedQuantity", null: false
    t.text "ProductDescription"
    t.string "Weight"
    t.string "Batch"
    t.string "MotherBatch"
    t.boolean "XMLExported", default: false, null: false
    t.timestamp "CreatedAt", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "UpdatedAt", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
    t.datetime "xml_exported_at"
    t.date "Best_Before_Date"
    t.index ["NicelabelId"], name: "NicelabelId", unique: true
  end


    t.boolean "XMLExported", default: false, null: false
    t.datetime "xml_exported_at"
    t.date "Best_Before_Date"

----

Hi Koen,

Outputs
Ons idee was om de huidige tabel table/view nicelabel_input te behouden en de batch nummer die hier uit komt te koppellen aan batch output.
Maar voor ons kan dit ook vanuit de productie app in een tabel waarna we de labels afdrukken. Het resultaat is hetzelfde al werken we vanaf de andere kant.
In eerste geval is label input, in tweede geval is label output.
Ik denk dat jouw suggestie dan beter en veiliger is en geen verdere data manipulatie vraagt, enkel nog printen (zie onder)

Wat wel nog als suggestie kwam is om de batchnummer die gegeneerd wordt bij de output niet 1-1 over te nemen van de productie maar deze random te maken. Zodat niet iemand op een etiket meteen kan aflezen wat productiedatum/tijd was. Eventueel batchnummer van batchcode random maken of maak de output dan random van de batchnummer.
Bijvoorbeeld 202503251855 wordt dan batchcode output 520512582035 (random nieuw getal laten maken met alle cijfers die voorkomen in. 520512582035)

Wat eigenlijk nodig is om de etiketten af te drukken zij alle kolommen uit nicelabel_input
behalve
print label
label_background_url
tht_months
Ik zou hier de tabel laten samenvallen met de batch_output. nadat de productie aangemaakt is en de verdeling van verpakking kan je nadien records selecteren en aantal etiketten met alle info afdrukken (quantity= aantal labels te drukken)

THT datum automatisch invullen
Momenteel heb ik het in Nicelabel zo opgezet dat hij uit nicelabel_input de tht date haalt en nadien schrijft Nicelabel deze weg naar Printed samen met batchcode om nadien deze batchcode weer op te halen en deze op het etiket aan te brengen.
het zou makkelijker zijn (ook om nadien kopieën van labels af te drukken) dat als een record geinsert wordt door Nicelabel hij de corresponderende tht date ophaalt uit Nicelabel_input op basis van code en dit schrijft(update) in Best_Before_Date.
Als we dan batchcode ophalen kan hij ook de tht dan ophalen en op etiket afdrukken.

De reden waarom ik dit zo wil omdat de datum nu een probleem geeft om exacte kopie van de label af te drukken (bv. als verpakking beschadigd is) dan pakt Nicelbabel tht van moment van printen ipv historische en krijg het niet opgelost door formatering van date.

kan je voor elke kolom van hieronder neerschrijven wat je denkt dat er moet in komen ?
Deze snap ik niet. is dit voor Printed? of voor nieuwe productie tabel?
Met vriendelijke groeten

Fréderique Debecker
+31 85 808 54 33

Banner Website.png
