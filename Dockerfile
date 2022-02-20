FROM node:14-alpine as build
WORKDIR /opt/app
ADD package*.json ./
RUN npm ci
ADD . .
RUN npm run build

FROM nginx:1.21-alpine
COPY --from=build /opt/app/build /usr/share/nginx/html
COPY --from=build /opt/app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD nginx -g "daemon off;"
