FROM node:10-alpine AS builder
WORKDIR /root/
COPY . /root/
RUN npm set registry https://registry.npm.taobao.org && \
        npm set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass
RUN npm install -g @angular/cli@latest && npm install
RUN ng build --prod --base-href=/ --deploy-url=/
RUN ls

FROM nginx:latest
COPY --from=builder /root/dist /usr/share/nginx/html/