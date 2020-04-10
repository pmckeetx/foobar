FROM node:lts as build

WORKDIR /usr/src/app

COPY package.json yarn.lock ./
RUN yarn

COPY . ./

RUN yarn build


# Stage 2 - the production environment
FROM nginx:alpine as prod

COPY --from=build /usr/src/app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]