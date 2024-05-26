FROM node:lts-alpine3.20

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

COPY sshd_config /etc/ssh/

COPY entrypoint.sh ./

RUN apk add openssh \
    && echo "root:Docker!" | chpasswd \
    && chmod +x ./entrypoint.sh \
    && cd /etc/ssh/ \
    && ssh-keygen -A

EXPOSE 3000 2222

ENTRYPOINT [ "./entrypoint.sh" ]
