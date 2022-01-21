# build stage
FROM node:lts-alpine as build
WORKDIR /app
RUN yarn config set registry https://registry.npm.taobao.org
COPY package*.json .
RUN yarn
COPY . .
RUN yarn build

# production stage
FROM nginx:stable-alpine as release
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]