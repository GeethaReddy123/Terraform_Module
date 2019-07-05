#!/bin/sh
#install Docker Engine
set -e
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y

#install jq for updating the code
sudo apt-get install jq -y

#Clone the code from GitHub
if [ -d /tmp/app ]
then
        sudo rm -rf /tmp/app
        echo "Clearing the old content!!!"
        sudo git clone https://github.com/test-ops/PA-CI-CD-test.git /tmp/app/
        echo "Cloning of the repository completed!!!"
else
        sudo git clone https://github.com/test-ops/PA-CI-CD-test.git /tmp/app/
        echo "Code Checkout successful!!!!"
fi


#Make neccessary changes in the code to work
#sudo chmod +x /tmp/app/package.json
jq '.main = "app.js"' /tmp/app/package.json > temp_package.json && sudo mv -f temp_package.json /tmp/app/package.json
jq 'del(.scripts.test)' /tmp/app/package.json > temp_package.json && sudo mv -f temp_package.json /tmp/app/package.json
jq '.scripts.start = "node app.js"' /tmp/app/package.json > temp_package.json && sudo mv -f temp_package.json /tmp/app/package.json
echo "File 'package.json' updated successfully"



#Create the Docker File
sudo bash -c 'cat <<EOT >> /tmp/app/Dockerfile
FROM node:8

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
EOT'

#Docker build and Run
sudo docker build -t node_js /tmp/app/
sudo docker run -p 8081:3000 --name my_app_nodejs -d node_js
