FROM mcr.microsoft.com/appsvc/node:10-lts

ENV HOST 0.0.0.0

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 2222 3000

#ENTRYPOINT ["pm2", "start", "--no-daemon", "/opt/startup/default-static-site.js"]

CMD service ssh start && npm start
