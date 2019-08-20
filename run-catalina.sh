#!/bin/bash -x

if [ ! -f "${MANAGER_PASSWORD_FILE}" ]; then
    echo "The manager-password secret is missing!" && exit 1
fi

# Generate properties to be added to conf/catalina.properties

tee -a conf/catalina.properties >/dev/null <<EOD
# auto-generated from ${0} at $(date)
manager.password=$(cat "${MANAGER_PASSWORD_FILE}")
db.resource-name=${DB_RESOURCE_NAME}
db.url=${DB_URL}
db.username=${DB_USERNAME}
db.password=$(test -f "${DB_PASSWORD_FILE}" && cat "${DB_PASSWORD_FILE}")
db.driver-class-name=${DB_DRIVER_CLASS_NAME}
EOD

# Run

exec catalina.sh run
