# 1단계: Build React App
FROM node:alpine as builder
WORKDIR /usr/src/app

COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

# 2단계: Serve with Nginx
FROM nginx:stable-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]