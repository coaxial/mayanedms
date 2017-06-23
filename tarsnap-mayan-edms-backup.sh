#!/usr/bin/env bash
# As per Mayan EDMS documentation for sqlite3 setups (cf
# https://bitbucket.org/r.rosario/mayan-edms-docker/src/4efe54e16538f5b605ad25a20f8560492ca61828/README.md)
datavolpath="$(docker volume inspect mayan_data | jq '.[0].Mountpoint' | sed \
    -e "s/\"//g")"; \
  docker stop mayan-edms &&\
  tarsnap -c -f "mayan-edms-$(date +%Y-%m-%d_%H-%M-%S)" \
    "$datavolpath/document_storage" \
    "$datavolpath/db.sqlite3" \
    "$datavolpath/settings" &&\
  docker start mayan-edms

# User variables
email=my_email@example.net
tarsnap_output_filename=/tmp/tarsnap-output-temporary.log

# Send email
if [ $? -eq 0 ]; then
  subject="Tarsnap backup success for Mayan EDMS"
else
  subject="Tarsnap backup FAILURE for Mayan EDMS"
fi
mail -s "$subject" $email < $tarsnap_output_filename
rm $tarsnap_output_filename
