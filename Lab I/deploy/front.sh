#!/bin/bash

SERVER_IP="$1"
SERVER_PORT="$2"
FRONTEND_PORT="$3"

# Init packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt autoremove -y
sudo apt-get install curl -y
sudo apt-get install npm -y

cd ~ 

# Install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install 16.14.2

# Petclinic forntend clone
cd ~/
git clone https://github.com/spring-petclinic/spring-petclinic-angular.git
cd spring-petclinic-angular/

# Update configuration
sed -i "s/localhost/$SERVER_IP/g" src/environments/environment.ts src/environments/environment.prod.ts
sed -i "s/9966/$SERVER_PORT/g" src/environments/environment.ts src/environments/environment.prod.ts

# Install angular
echo N | npm install -g @angular/cli@latest
echo N | npm install
echo N | ng analytics off

npm install angular-http-server
npm audit fix

# Build project in production mode.
npm run build -- --prod

# Start server using angular-http-server
npx angular-http-server --path ./dist -p $FRONTEND_PORT &

echo DONE
