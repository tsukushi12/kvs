require "open3"
print `rsync -uvrz --inplace --progress ./db/ pi@localhost:/home/pi/kvs/db2`
