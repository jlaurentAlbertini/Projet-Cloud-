# Étape 1 : build de l'app React
FROM node:18 as build

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Étape 2 : image finale, serveur Nginx
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]