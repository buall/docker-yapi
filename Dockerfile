FROM node:12-buster-slim


ENV YAPI_VERSION="1.9.2" \
	DB_HOST="127.0.0.1" \
	DB_PORT="27017" \
	DB_NAME="yapi" \
	DB_USER="" \
	DB_PASSWORD="" \
	YAPI_PORT="3000" \
	YAPI_ACCOUNT="admin@admin.com" \
	ALLOW_REGISTER=true


COPY ./start.sh /start.sh


RUN apt-get update -y && apt-get install python make wget unzip -y; \
	country=`wget -qO- --timeout=2 --tries=5 ipinfo.io | grep "country" | awk '{print $2}' | grep -oE '[a-zA-Z]{2,}'`; \
	[ -n "$country" -a "$country" = "CN" ] && YAPI_URL="https://gitee.com/mirrors/YApi/repository/archive/v${YAPI_VERSION}.zip" || YAPI_URL="https://github.com/YMFE/yapi/archive/refs/tags/v${YAPI_VERSION}.zip"; \
	[ -n "$country" -a "$country" = "CN" ] && npm config set registry https://registry.npm.taobao.org; \
	echo "YAPI Download Address: ${YAPI_URL}"; \
	wget ${YAPI_URL}; \
	mkdir -p /yapi; \
	unzip v${YAPI_VERSION}.zip -d /yapi; \
	[ -n "$country" -a "$country" = "CN" ] && mv /yapi/YApi /yapi/vendors || mv /yapi/yapi-${YAPI_VERSION} /yapi/vendors; \
	cd /yapi/vendors; \
	cp /yapi/vendors/config_example.json /yapi/config.json; \
	sed -i '3a\  "versionNotify": true,' /yapi/config.json; \
	sed -i '4a\  "closeRegister": false,' /yapi/config.json; \
	sed -i "s|\"user\"\:\ \"test1\"|\"user\"\:\ \"\"|g" /yapi/config.json; \
	sed -i "s|\"pass\"\:\ \"test1\"|\"pass\"\:\ \"\"|g" /yapi/config.json; \
	npm install -g node-gyp; \
	npm install --production; \
	rm -f /v${YAPI_VERSION}.zip && apt-get remove wget unzip --purge -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*


CMD ["/start.sh"]
