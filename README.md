# Mayan EDMS custom image

I need extra languages for OCR, hence this custom derivative Mayan EDMS image.

Use as `coaxial/mayanedms` instead of `mayanedms/mayanedms` in commands.

## Starting

> Requires docker to be up and running

`$ docker run -d --name mayan-edms --restart=always -p 8080:80 -v mayan_data:/var/lib/mayan coaxial/mayanedms`

## Upgrading

`$ docker stop mayan-edms && docker rm mayan-edms && docker pull
coaxial/mayanedms` and then run the starting command again.

## Backing up

Via a cronjob (assumes `/backups` exists): 
```bash
datavolpath="$(sudo docker volume inspect mayan_data | jq
'.[0].Mountpoint' | sed -e "s/\"//g")"; sudo tar -zcvf /backups/mayan_data.tar.gz
"$datavolpath/document_storage" "$datavolpath/db.sqlite3"
"$datavolpath/settings"
```

## Restoring backup

> Assumes the data volume on the target instance is also named `mayan_data`

`$ sudo tar -xvzf mayan_data.tar.gz -C /`
