#! /bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install necessary software
apt-get update -y && apt-get install python make wget unzip -y

# Download source code
country=`wget -qO- --timeout=2 --tries=5 ipinfo.io | grep "country" | awk '{print $2}' | grep -oE '[a-zA-Z]{2,}'`
if [ -n $country ]; then
        if [ $country = "CN" ]; then
            YAPI_URL="https://gitee.com/mirrors/YApi/repository/archive/${YAPI_VERSION}.zip" && npm config set registry https://registry.npm.taobao.org
        else
            YAPI_URL="https://github.com/YMFE/yapi/archive/refs/tags/${YAPI_VERSION}.zip"
        fi
    else
        YAPI_URL="https://gitee.com/mirrors/YApi/repository/archive/${YAPI_VERSION}.zip" && npm config set registry https://registry.npm.taobao.org
fi
echo "YAPI Download Address: ${YAPI_URL}"
wget ${YAPI_URL}
mkdir -p /yapi
unzip ${YAPI_VERSION}.zip -d /yapi
mv /yapi/YApi /yapi/vendors
cd /yapi/vendors

### INIT CONFIG
cp /yapi/vendors/config_example.json /yapi/config.json
sed -i '3a\  "versionNotify": true,' /yapi/config.json
sed -i '4a\  "closeRegister": false,' /yapi/config.json
sed -i "s|\"user\"\:\ \"test1\"|\"user\"\:\ \"\"|g" /yapi/config.json
sed -i "s|\"pass\"\:\ \"test1\"|\"pass\"\:\ \"\"|g" /yapi/config.json

npm install -g node-gyp
npm install --production

# Delete unnecessary files
rm -f /${YAPI_VERSION}.zip && apt-get remove wget unzip --purge -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
