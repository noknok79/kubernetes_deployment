#!/bin/bash
apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && apt update -y && apt-get install docker-ce docker-ce-cli containerd.io -y && apt update -y
/lib/systemd/systemd-sysv-install enable docker
systemctl start docker
docker run -d -p 27017:27017 --name mongo -v /data/db:/data/db mongo:latest 
docker run -d -p 8080:8080 --link mongo:mongo noknok79/parts-order:latest 
docker run -it -d --name web -p 80:80 noknok79/parts-web:latest 




























