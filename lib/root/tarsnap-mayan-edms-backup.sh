#!/usr/bin/env bash
# As per Mayan EDMS documentation for sqlite3 setups (cf
# https://bitbucket.org/r.rosario/mayan-edms-docker/src/4efe54e16538f5b605ad25a20f8560492ca61828/README.md)

# User variables
email=my_email@example.net
tarsnap_output_filename=/tmp/tarsnap-output-temporary.log

tarsnapper -c /etc/tarsnapperrc.yml make > $tarsnap_output_filename 2>&1

# Send email
if [ $? -eq 0 ]; then
  subject="Tarsnap backup success for Mayan EDMS"
else
  subject="Tarsnap backup FAILURE for Mayan EDMS"
fi
mail -s "$subject" $email < $tarsnap_output_filename
rm $tarsnap_output_filename
