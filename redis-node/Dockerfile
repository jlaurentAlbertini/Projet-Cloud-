FROM node:18

WORKDIR /app

COPY . .

RUN npm install --legacy-peer-deps

EXPOSE 8080

CMD ["node", "main.js"]