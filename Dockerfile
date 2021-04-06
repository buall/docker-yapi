FROM node:12-buster-slim

ENV YAPI_VERSION="v1.9.2"
ENV DB_HOST="127.0.0.1"
ENV DB_PORT="27017"
ENV DB_NAME="yapi"
ENV DB_USER=""
ENV DB_PASSWORD=""
ENV YAPI_PORT="3000"
ENV YAPI_ACCOUNT="admin@admin.com"

COPY ./build.sh /build.sh
COPY ./start.sh /start.sh
RUN /build.sh && rm -f /build.sh
CMD ["/start.sh"]
