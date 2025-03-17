# README

Bio-Ron RePacMan

# fetch db to local

    mysql -e "CREATE DATABASE bioron_packageup;"
    rm remote_dump.sql
    mysqldump -h eek.h.filess.io -u bioron_packageup -p --no-tablespaces bioron_packageup > remote_dump.sql
    mysql bioron_packageup < remote_dump.sql
