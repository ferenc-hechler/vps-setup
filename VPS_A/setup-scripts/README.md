# Step 1 - Create User

after starting with a fresh ubuntu 22.04 image create a user with sudo rights and ssh login.
Execute as root user:

```
curl -O https://raw.githubusercontent.com/ferenc-hechler/vps-setup/main/vps-a/setup-scripts/01-create-user.sh
chmod u+x 01-create-user.sh
./01-create-user.sh ferenc
   <enter hidden password>

# cleanup
rm 01-create-user.sh
```

login as newly created user