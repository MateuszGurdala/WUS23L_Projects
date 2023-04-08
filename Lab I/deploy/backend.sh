#!/bin/bash

#Arguments
database_ip=$1
database_port=$2
backend_port=$3

cd /root
sudo apt update
sudo apt upgrade -y
sudo apt install -y default-jre
sudo apt install git
git clone https://github.com/spring-petclinic/spring-petclinic-rest.git
cd spring-petclinic-rest
sed -i "s/localhost/$database_ip/g" src/main/resources/application-mysql.properties
sed -i "s/3306/$database_port/g" src/main/resources/application-mysql.properties
sed -i "s/9966/$backend_port/g" src/main/resources/application.properties
sed -i "s/active=hsqldb/active=mysql/g" src/main/resources/application.properties
./mvnw spring-boot:run &
