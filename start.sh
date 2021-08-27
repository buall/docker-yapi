#! /bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

## MONGO INFO
# DB HOST
sed -i "s|\"servername\"\:\ \"127.0.0.1\"|\"servername\"\:\ \"$DB_HOST\"|g" /yapi/config.json
# DB PORT
sed -i "s|\"port\"\:\ 27017|\"port\"\:\ $DB_PORT|g" /yapi/config.json
# DB_NAME
sed -i "s|\"DATABASE\"\:\ \"yapi\"|\"DATABASE\"\:\ \"$DB_NAME\"|g" /yapi/config.json

# DB USERNAME
sed -i "s|\"user\"\:\ \"\"|\"user\"\:\ \"$DB_USER\"|g" /yapi/config.json
# DB PASSWORD
sed -i "s|\"pass\"\:\ \"\"|\"pass\"\:\ \"$DB_PASSWORD\"|g" /yapi/config.json

## YAPI INFO
# YAPI PORT
sed -i "s|\"port\"\:\ \"3000\"|\"port\"\:\ \"$YAPI_PORT\"|g" /yapi/config.json
# YAPI ADMIN ACCOUNT
sed -i "s|\"adminAccount\"\:\ \"admin@admin.com\"|\"adminAccount\"\:\ \"$YAPI_ACCOUNT\"|g" /yapi/config.json

# REGISTER MODULE
# if [ ${ALLOW_REGISTER}=="false" ]; then
# 	sed -i "s|\"closeRegister\"\:\ false|\"closeRegister\"\:\ true|g" /yapi/config.json
# fi

# Install server
if [ ! -f /yapi/init.lock ]; then
    cd /yapi/vendors && npm run install-server
fi
# Start server
cd /yapi/vendors && node server/app.js
