FROM node:latest

ENV PORT 3000

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN apt-get update && apt-get install -y openssh-server

RUN mkdir /var/run/sshd
RUN echo "root:Docker!" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN chmod 600 /etc/ssh/sshd_config

EXPOSE 2222 3000

CMD service ssh start && npm start