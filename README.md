# TWiki-Docker
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


## Example

### Build docker image
```
docker build --tag twiki:6.0.2 github.com/mharrend/docker-twiki
```

### Start docker container from image
```bash
docker run  --restart=always  -dt -p 80:80 -v /home/data/:/data -e URL_HOST=http://10.11.12.13:80/ -e ADMIN_PW=pass1234 -e ADMIN_EMAIL=admin@email -e ADMIN_NAME="Twiki admin" twiki
```

## Note: Forked
This repository was forked from https://github.com/BundesIT/twiki-docker and then modified, so that a newer OS and TWiki version and so on will be used.
