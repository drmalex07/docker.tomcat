# docker.tomcat

A docker-compose recipe for a Tomcat server instance

## Generate certificate for HTTPS

The HTTPS configuration on APR implementation ([more](https://tomcat.apache.org/tomcat-8.5-doc/ssl-howto.html#Configuration)) requires keys and certificates in `PEM` format (unlike the configuration on JSSE which requires them as keystore).

If we already have a `PKCS12` bundle, we can unpack its components (keys and certificates) with something like:

    openssl pkcs12 -in keystore.p12 -nocerts
    openssl pkcs12 -in keystore.p12 -nokeys

## Prepare directory

Create a directory `certs` to hold keys and certificates:

    * `root.crt`: A certificate bundle with our trusted authorities (CAs)
    * `server.crt`: The server's certificate in `PEM` format (usually signed by someone from `root.crt`)
    * `server.key`: The server's key in `PEM` format

Create a directory to hold secrets (to be mounted in container):

    mkdir secrets
    # edit secrets/db-password, secrets/manager-password, secrets/keystore-password ...

Note that `secrets/keystore-password` holds the password for the password-protected private key (`certs/server.key`)

Copy `docker-compose.yml.example` to `docker-compose.yml` and edit to adjust to your needs. 

Place your provided dependencies (e.g. driver JAR for the database resource) under `dependency`, and
define relevant bind mounts inside `docker-compose.yml`.

Place your webapps under `webapps` and define a relevant bind mount inside `docker-compose.yml`

## Run

Build local image:

    docker-compose build

Run server:

    docker-compose up tomcat
