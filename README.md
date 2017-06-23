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

- Copy the `tarsnap-mayan-edms-backup.sh` script to `/root/`

- Set the permissions:
```bash
$ chown root:root /root/tarsnap-mayan-edms-backup.sh && chmod 600
/root/tarnsap-mayan-edms-backup.sh && chmod u+x
/root/tarsnap-mayan-edms-backup.sh
```

- Edit the reporting email in `tarsnap-mayan-edms-backup.sh`

- Add a cronjob:
```bash
# Backup Mayan EDMS data to tarnsap
12 2 * * * /root/tarsnap-mayan-edms-backup.sh
```

## Restoring backup

> Assumes the data volume on the target instance is also named `mayan_data`

- List available backups: `$ sudo tarsnap --list-archives | sort`
- Restore chosen backup: `$ sudo tarnsap -x -f <backup-name>`
