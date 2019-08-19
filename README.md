# docker.tomcat

A docker-compose recipe for a Tomcat server instance

## Generate certificate for HTTPS

The following is only an example of generating a proper PKCS12 bundle using `keytool` (same result can also be produced using openssl suite).

Generate a key-pair, say for a host `baz.example.com`:

    keytool -genkeypair -alias server -keyalg RSA -keystore keystore.p12 -storetype pkcs12 \
        -dname 'CN=baz.example.com, OU=IT, O=Nowhere Land, L=Athens, ST=Greece, C=GR'
        
Generate a certificate request (CSR):

    keytool -certreq -alias server -keystore keystore.p12 -file server.csr    

Trust the CA that is signing our certificate (say `root.crt` is the CA certificate):

    keytool -importcert -alias root -keystore keystore.p12 -trustcacerts -file root.crt

After a CA has signed our certificate (say as `server.crt`), replace the self-signed certificate into the keystore:

    keytool -importcert -alias server -keystore keystore.p12 -file server.crt

## Prepare directory

Create a directory to hold secrets (to be mounted in container):

    mkdir secrets
    # edit secrets/db-password, secrets/manager-password, secrets/keystore-password ...

Place PKCS12 keystore `keystore.p12` under current directory.

Copy `docker-compose.yml.example` to `docker-compose.yml` and edit to adjust to your needs. 

Place your provided dependencies (e.g. driver JAR for the database resource) under `dependency`, and
define relevant bind mounts inside `docker-compose.yml`.

Place your webapps under `webapps` and define a relevant bind mount inside `docker-compose.yml`

## Run

Build local image:

    docker-compose build

Run server:

    docker-compose up tomcat
