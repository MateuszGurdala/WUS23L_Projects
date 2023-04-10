#!/bin/bash

SERVER_IP="$1"
SERVER_PORT="$2"
FRONTEND_PORT="$3"

sudo apt update
sudo apt upgrade -y

# Install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 16.14.2
# nvm install v18.15.0 -> needs to be downgraded

npm install -g @angular/cli@latest
npm install angular-http-server

git clone https://github.com/spring-petclinic/spring-petclinic-angular.git
cd spring-petclinic-angular
npm install

# Update configuration
sed -i "s/localhost/$SERVER_IP/g" src/environments/environment.ts src/environments/environment.prod.ts
sed -i "s/9966/$SERVER_PORT/g" src/environments/environment.ts src/environments/environment.prod.ts

npm run build

npx angular-http-server --path ./dist -p $FRONTEND_PORT &
