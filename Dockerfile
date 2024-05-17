FROM node:latest

WORKDIR /

ENV SSH_PASSWD "root:Docker!"

RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog openssh-server \
    && echo "$SSH_PASSWD" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && mkdir /run/sshd \
    && echo '#!/bin/bash\n/usr/sbin/sshd -D' > /start_sshd.sh \
    && chmod +x /start_sshd.sh

EXPOSE 3000 2222

COPY package*.json ./
COPY index.js ./

RUN npm install

CMD ["/start_sshd.sh"]
