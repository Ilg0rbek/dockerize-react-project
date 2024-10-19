FROM node:alpine as builder

# project name
WORKDIR /client

COPY ./package.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

# porject port
EXPOSE 3000  

# nginx config file name default.conf is domain name
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /client/build /usr/share/nginx/html