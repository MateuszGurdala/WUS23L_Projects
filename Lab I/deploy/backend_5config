#!/bin/bash

#Arguments
db1_ip=$1
db1_port=$2
db2_ip=$3
db2_port=$4
backend1_port=$5
backend2_port=$6

#Update environment
sudo apt update
sudo apt upgrade -y

#Install dependencies
sudo apt install openjdk-17-jre -y
sudo apt install maven -y
sudo apt install git -y

#Clone spring-petclinic-rest into two separate directories
cd /home
HOME_DIR="$(ls)"
HOME_PATH="/home/$HOME_DIR"
cd $HOME_PATH

#Clone first backend
git clone https://github.com/spring-petclinic/spring-petclinic-rest.git
cd spring-petclinic-rest

#Update first backend database properties
sudo sed -i "s/localhost/$db1_ip/g" src/main/resources/application-mysql.properties
sudo sed -i "s/3306/$db1_port/g" src/main/resources/application-mysql.properties
sudo sed -i "s/9966/$backend1_port/g" src/main/resources/application.properties
sudo sed -i "s/active=hsqldb/active=mysql/g" src/main/resources/application.properties

#Run first backend
sudo ./mvnw spring-boot:run &

#Clone second backend
cd $HOME_PATH
git clone https://github.com/spring-petclinic/spring-petclinic-rest.git petclinic2
cd petclinic2

#Update second backend database properties
sudo sed -i "s/localhost/$db2_ip/g" src/main/resources/application-mysql.properties
sudo sed -i "s/3306/$db2_port/g" src/main/resources/application-mysql.properties
sudo sed -i "s/9966/$backend2_port/g" src/main/resources/application.properties
sudo sed -i "s/active=hsqldb/active=mysql/g" src/main/resources/application.properties

#Run second backend
sudo ./mvnw spring-boot:run &
