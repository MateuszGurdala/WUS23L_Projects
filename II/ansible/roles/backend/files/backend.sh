#!/bin/bash

#Arguments
database_ip=$1
database_port=$2
backend_port=$3

#Update denviroment
sudo apt update
sudo apt upgrade -y

# sudo apt install -y default-jre -> installs jre-11
sudo apt install openjdk-17-jre -y
sudo apt install maven -y
sudo apt install git -y

#Clone spring-petclinic-rest
cd /home
HOME_DIR="$(ls)"
HOME_PATH="/home/$HOME_DIR"
cd $HOME_PATH
git clone https://github.com/spring-petclinic/spring-petclinic-rest.git
cd spring-petclinic-rest

#Change database ip, database port and backend port
sudo sed -i "s/localhost/$database_ip/g" src/main/resources/application-mysql.properties
sudo sed -i "s/3306/$database_port/g" src/main/resources/application-mysql.properties
sudo sed -i "s/9966/$backend_port/g" src/main/resources/application.properties
sudo sed -i "s/active=hsqldb/active=mysql/g" src/main/resources/application.properties
sudo sed -i 's/username=.*/username=pc/' src/main/resources/application-mysql.properties
sudo sed -i 's/password=.*/password=petclinic/' src/main/resources/application-mysql.properties

#Run backend
tmux new-session -d "sudo ./mvnw spring-boot:run"
