FROM node:latest

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

ENV SSH_PASSWD "root:Docker!"

RUN apt-get update && apt-get install -y openssh-server

RUN mkdir /var/run/sshd
RUN echo "$SSH_PASSWD" | chpasswd \
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22 3000

CMD ["node", "index.js"]
