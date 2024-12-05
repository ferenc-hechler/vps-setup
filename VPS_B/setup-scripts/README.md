# Step 1 - Create User

after starting with a fresh ubuntu 22.04 image create a user with sudo rights and ssh login.
Execute as root user:

```
curl -sO https://raw.githubusercontent.com/ferenc-hechler/vps-setup/refs/heads/main/VPS_B/setup-scripts/01-create-user.sh
chmod u+x 01-create-user.sh
./01-create-user.sh ferenc
   <enter hidden password>

# cleanup
rm 01-create-user.sh
```

login as newly created user


# Step 2 - clone repo

```
mkdir -p ~/git
cd ~/git
git clone https://github.com/ferenc-hechler/vps-setup.git
```



# 04 NextCloud

## access database

```
docker exec -it nextcloud-aio-database psql -U oc_nextcloud nextcloud_database
```

## create a db dump

https://www.ionos.com/digitalguide/server/security/postgresql-backup/?srsltid=AfmBOooYNwG1bnT7rJb9_qcPA7YVbTGOMG4PpQUoDnAon2OlmjHFvUQM

```
docker exec -it nextcloud-aio-database pg_dump --clean --create -U oc_nextcloud nextcloud_database > pg-dump.sql
```



## backup ncdata

```
tar cvzf ncdata.tgz -C ~/ncdata .
```

## backup config

```
docker exec -it nextcloud-aio-mastercontainer cat /mnt/docker-aio-config/data/configuration.json > data-configuration.json

docker exec nextcloud-aio-mastercontainer tar cz -C /mnt/docker-aio-config .  > docker-aio-config.tgz
```

```
docker exec -i nextcloud-aio-nextcloud cat /var/www/html/config/config.php > config.php
 ```

# restore

## restore ncdata

```
sudo tar xz -C ~ferenc/ncdata < ncdata.tgz
```


## copy config json

```
docker container exec -i nextcloud-aio-mastercontainer "sh -c cat >/mnt/docker-aio-config/data/configuration.json" < configuration.json
chown www-data:www-data /mnt/docker-aio-config/data/configuration.json
chmod 770 /mnt/docker-aio-config/data/configuration.json

```

patch domain name if neccessary 

## shutdown nextcloud-aio-mastercontainer

```
docker container stop nextcloud-aio-mastercontainer
docker container start nextcloud-aio-apache
docker container stop nextcloud-aio-nextcloud
```



## restore DB

https://github.com/nextcloud/all-in-one/discussions/2143


```
docker exec nextcloud-aio-database dropdb -U nextcloud nextcloud_database -f
docker exec nextcloud-aio-database createdb -U nextcloud nextcloud_database

docker exec -i nextcloud-aio-database psql -U nextcloud nextcloud_database < pg-dump.sql
```

## start nextcloud-aio-mastercontainer

```
docker container start nextcloud-aio-nextcloud
docker container start nextcloud-aio-apache
docker container start nextcloud-aio-mastercontainer
```

