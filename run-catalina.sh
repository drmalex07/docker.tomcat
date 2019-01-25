#!/bin/bash -x

if [ ! -f "${MANAGER_PASSWORD_FILE}" ]; then
    echo "The password file (MANAGER_PASSWORD_FILE) is missing: ${MANAGER_PASSWORD_FILE}" && exit 1
fi

if [ ! -f "${DB_PASSWORD_FILE}" ]; then
    echo "The password file (DB_PASSWORD_FILE) is missing: ${DB_PASSWORD_FILE}" && exit 1
fi

# Generate properties to be added to conf/catalina.properties

tee -a conf/catalina.properties >/dev/null <<EOD

# Auto-generated from ${0}
manager.password=$(cat ${MANAGER_PASSWORD_FILE})
db.host=${DB_HOST}
db.port=${DB_PORT}
db.name=${DB_NAME}
db.username=${DB_USERNAME}
db.password=$(cat ${DB_PASSWORD_FILE})

EOD

# Run

exec catalina.sh run
