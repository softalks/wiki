# Docker-TWiki
A Dockerized TWiki
* Version 6.0.2
* Following features are enabled by default
  * SSL encryption
  * LDAPContrib plugin installation

Nota: Se pretende añadir [soporte al encoding es_ES.ISO-8859-1](EsEsIso88591)

## USAGE
All Data will be stored under `/data`. You should attach some
external storage there ` -v /mnt/twiki:/data`.

Nota: Es posible que este mapeo implique asignar unos persmisos específicos al directorio del contenedor y al del servidor que ejecuta docker

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
| URL\_HOST     | https://localhost   | Full URL ( as received by the webserver ) |
| SCRIPT\_PATH  | /bin                  | URI Path to "bin"      |
| PUP\_PATH     | /pub                  | URI Path to "pub"      |
Note: This variables have to be set during run time via 
```bash
docker run ... \
-e ADMIN\_PW=changeme \
-e ADMIN\_EMAIL=admin@domain.com \
-e ADMIN\_NAME="TWiki administrator" \
-e URL\_HOST=https://localhost \
-e SCRIPT\_PATH=/bin \
-e PUP\_PATH=/pub \
...
```

## SSL-Encryption
* You have to provide a fullchain server certificate called wiki-fullchain.pem and server key called wiki-key.pem via the data/ssl-certs subfolder of the data container.

## LDAP integration
* If you would like to make use of LDAP integration, you have to adjust the data/lib/LocalSite.cfg file.
* You can check configs/LocalSite.cfg.ldap for a template.


## Example

### Build docker image
```bash
docker build --tag twiki-ssl-ldap:6.0.2  github.com/mharrend/docker-twiki
```

### Start docker container from image
```bash
docker run  --restart=always  -dt -p 80:80 -p 443:443 -v /docker:/data twiki-ssl-ldap:6.0.2
```

## Note: Forked
This repository was forked from https://github.com/BundesIT/twiki-docker and then modified, so that a newer OS and TWiki version and so on will be used.
