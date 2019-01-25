# docker.tomcat

A docker-compose recipe for a Tomcat server instance

## Prepare 

Create a directory to hold secrets (to be mounted in container):

    mkdir secrets
    # edit secrets/db-password and secrets/manager-password ...

Copy `docker-compose.yml.example` to `docker-compose.yml` and edit to adjust to your needs. 

Place your webapps under `webapps` and define a relevant bind mount inside `docker-compose.yml`

## Run

Build local image:

    docker-compose build

Run server:

    docker-compose up tomcat
