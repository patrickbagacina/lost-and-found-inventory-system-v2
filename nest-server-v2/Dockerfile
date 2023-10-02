FROM node:16

RUN mkdir -p /app

WORKDIR /app

COPY ./nest-server-v2/package*.json ./

RUN ls

RUN npm ci

COPY ./nest-server-v2 ./

EXPOSE 3000

RUN npm run build

CMD [ "npm", "run", "start:prod" ]