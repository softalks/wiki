# Docker-TWiki
A Dockerized TWiki
* Version 6.0.2
* Following features are enabled by default
  * SSL encryption
  * LDAPContrib plugin installation

## USAGE
All Data will be stored under `/data`. You should attach some
external storage there ` -v /mnt/twiki:/data`.

## Data container
* The data container is used to store the most important TWiki configurations in subfolder

| data subfolder |    description            |
|---------------|-----------------------|
| data/data      | Contains twiki data       |
| data/pub       | Contains twiki public data like files |
| data/ssl-certs | Contains wiki-fullchain.pem and wiki-key.pem |
| data/lib | Can contain LocalSite.cfg from the beginning or will contain it after preparation step |

##  TWiki configuration 
* You have two options to configure the TWiki.
  1. You provide a LocalSite.cfg file in the data/lib subfolder of the data container containing all the important information. You can checkout the configs/LocalSite.cfg file in this repo as a template.
  2. You do not provide a LocalSite.cfg file and instead make use of the the following environment variables. A basic LocalSite.cfg file will be created for you which you adjust further directly or by making use of it being mounted in the data container.

|   VAR         |    default            | description            |
|---------------|-----------------------|------------------------|
| ADMIN\_PW     | changeme              | Administrator Password |
| ADMIN\_EMAIL  | changeme              | Administrator email address |
| ADMIN\_NAME   | TWiki administrator   | Administrator name |
| URL\_HOST     | http://localhost:80   | Full URL ( as received by the webserver ) |
| SCRIPT\_PATH  | /bin                  | URI Path to "bin"      |
| PUP\_PATH     | /pub                  | URI Path to "pub"      |
Note: This variables have to be set during build time via 
```
docker build --build-arg ADMIN_PW ...
```

## SSL-Encryption
* You have to provide a fullchain server certificate called wiki-fullchain.pem and server key called wiki-key.pem via the data/ssl-certs subfolder of the data container.

## LDAP integration
* If you would like to make use of LDAP integration, you have to adjust the data/lib/LocalSite.cfg file.
* You can check configs/LocalSite.cfg.ldap for a template.


## Example

### Build docker image
```
docker build --tag twiki:6.0.2  --build-arg URL_HOST=http://10.11.12.13:80/ --build-arg ADMIN_PW=pass1234 --build-arg ADMIN_EMAIL=admin@email --build-arg ADMIN_NAME="Twiki admin" github.com/mharrend/docker-twiki
```

### Start docker container from image
```bash
docker run  --restart=always  -dt -p 80:80 -v /home/data/:/data twiki:6.0.2
```

## Note: Forked
This repository was forked from https://github.com/BundesIT/twiki-docker and then modified, so that a newer OS and TWiki version and so on will be used.
