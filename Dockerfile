FROM node:18-alpine

WORKDIR /app

RUN npm install -g npm@9

COPY package*.json .
COPY packages ./packages
COPY translations ./translations

RUN npm install

EXPOSE 3000

CMD ["npm", "start"]
