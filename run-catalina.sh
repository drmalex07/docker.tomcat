#!/bin/bash -x

if [ ! -f "${MANAGER_PASSWORD_FILE}" ]; then
    echo "The password file (MANAGER_PASSWORD_FILE) is missing: ${MANAGER_PASSWORD_FILE}" && exit 1
fi

if [ ! -f "${DB_PASSWORD_FILE}" ]; then
    echo "The password file (DB_PASSWORD_FILE) is missing: ${DB_PASSWORD_FILE}" && exit 1
fi

if [ ! -f "${KEYSTORE_PASSWORD_FILE}" ]; then
    echo "The password file (KEYSTORE_PASSWORD_FILE) is missing: ${KEYSTORE_PASSWORD_FILE}" && exit 1
fi

# Generate properties to be added to conf/catalina.properties

tee -a conf/catalina.properties >/dev/null <<EOD
# auto-generated from ${0} at $(date)
keystore.password=$(cat ${KEYSTORE_PASSWORD_FILE})
manager.password=$(cat ${MANAGER_PASSWORD_FILE})
db.resource-name=${DB_RESOURCE_NAME}
db.url=${DB_URL}
db.username=${DB_USERNAME}
db.password=$(cat ${DB_PASSWORD_FILE})
db.driver-class-name=${DB_DRIVER_CLASS_NAME}
EOD

# Run

exec catalina.sh run
