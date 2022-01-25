# using node to build an app
FROM node:12 as build-stage
WORKDIR /app

COPY package*.json /app/
RUN npm install

COPY ./ /app/
RUN npm run build

# ready for serving frontend using nginx
FROM nginx
COPY --from=build-stage /app/build/ /usr/share/nginx/html

# Copy the nginx configuration from build stage
COPY --from=build-stage /nginx.conf /etc/nginx/conf.d/default.con