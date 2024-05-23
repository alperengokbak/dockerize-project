FROM node:16

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

RUN echo 'root:Docker!' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/Port 22/Port 2222/' /etc/ssh/sshd_config

EXPOSE 2222 3000

CMD service ssh start && node index.js
