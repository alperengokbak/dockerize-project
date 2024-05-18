FROM node:latest

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

ENV SSH_PASSWD "root:Docker!"

RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog openssh-server \
    && echo "$SSH_PASSWD" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

COPY . .

EXPOSE 3000 2222

COPY package*.json ./
COPY index.js ./

CMD ["node", "index.js"]
