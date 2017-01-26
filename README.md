# Docker-TWiki
A Dockerized TWiki

## USAGE
All Data will be stored under `/data`. You should attach some
external storage there ` -v /mnt/twiki:/data`

The following environment variables are parsed and used at the moment

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


## Example

### Build docker image
```
docker build --tag twiki:6.0.2  --build-arg URL_HOST=http://10.11.12.13:80/ --build-arg ADMIN_PW=pass1234 --build-arg ADMIN_EMAIL=admin@email --build-arg ADMIN_NAME="Twiki admin" github.com/mharrend/docker-twiki
```

### Start docker container from image
```bash
docker run  --restart=always  -dt -p 80:80 -v /home/data/:/data twiki
```

## Note: Forked
This repository was forked from https://github.com/BundesIT/twiki-docker and then modified, so that a newer OS and TWiki version and so on will be used.
