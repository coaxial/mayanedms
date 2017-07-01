# Mayan EDMS custom image

I need extra languages for OCR, hence this custom derivative Mayan EDMS image.

Use as `coaxial/mayanedms` instead of `mayanedms/mayanedms` in commands.

## Starting

> Requires docker to be up and running

```
$ docker run \
  --detach \
  --name mayan-edms \
  --restart=always \
  --publish 8080:80 \
  --volume mayan_data:/var/lib/mayan \
  --volume mayan_dropbox:/srv/scanned_documents \
  coaxial/mayanedms
```

## Volumes

The directory at `/srv/scanned_documents` is watched by Mayan EDMS to
automatically import any document dropped in it. This is used in combination
with coaxial/ct2p to easily ingest scanned documents prepped for OCR.

## Upgrading

`$ docker stop mayan-edms && docker rm mayan-edms && docker pull
coaxial/mayanedms` and then run the starting command again.

## Backing up

> Assumes docker and Mayan are running, tarsnap is installed and setup with the
> relevant key ([instructions](https://www.tarsnap.com/gettingstarted.html)),
> and that tarsnapper is ready to go
> ([instructions](https://github.com/miracle2k/tarsnapper)).

- Unpack the `lib/backup_setup.tar.gz` archive on the target machine at `/`
  with `sudo`

- Edit the email address in the backup script at
  `/root/tarsnap-mayan-edms-backup.sh`

- Set the permissions on the backup script:
```bash
$ chown root:root /root/tarsnap-mayan-edms-backup.sh && chmod 600
/root/tarnsap-mayan-edms-backup.sh && chmod u+x
/root/tarsnap-mayan-edms-backup.sh
```

- Add a cronjob:
```bash
# Backup Mayan EDMS data to tarnsap
12 2 * * * /root/tarsnap-mayan-edms-backup.sh
```

- Setup msmtp ([instructions](https://wiki.archlinux.org/index.php/Msmtp)

- Test the setup by running the script `sudo
  /root/tarsnap-mayan-edms-backup.sh`, checking if it ran successfully, and
whether an email was dispatched

## Restoring backup

> Assumes the data volume on the target instance is also named `mayan_data`

- List available backups: `$ sudo tarsnap --list-archives | sort`
- Restore chosen backup: `$ sudo tarnsap -x -f <backup-name>`

## TODO

This could be an ansible playbook...
