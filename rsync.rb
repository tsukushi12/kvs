require "open3"
print `rsync -uvrz --inplace --progress -e "ssh -i ~.ssh/kvs.pem" pi@localhost:/home/pi/kvs/db/ ./db2/`
