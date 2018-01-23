FROM nginx:1.13.3-alpine

## Copy our nginx config
#COPY nginx/ /opt/app-root/etc/nginx.default.d/

## Remove default nginx website
#RUN rm -rf /usr/share/nginx/html/*

## copy over the artifacts in dist folder to default nginx public folder
COPY dist/ /opt/app-root/src

EXPOSE 8080

CMD $STI_SCRIPTS_PATH/run
