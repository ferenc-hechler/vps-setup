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

```
docker exec -it nextcloud-aio-database pg_dump -U oc_nextcloud nextcloud_database > pg-dump.sql
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
