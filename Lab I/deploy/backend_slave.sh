#!/bin/bash

# Arguments
master_ip=$1
master_port=$2
slave_ip=$3
slave_port=$4
backend_port=$5

# Update environment
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install openjdk-17-jre -y
sudo apt install maven -y
sudo apt install git -y

# Clone spring-petclinic-rest
cd /home
HOME_DIR="$(ls)"
HOME_PATH="/home/$HOME_DIR"
cd $HOME_PATH
git clone https://github.com/spring-petclinic/spring-petclinic-rest.git
cd spring-petclinic-rest

# Update database properties
sudo sed -i "s/localhost/$master_ip/g" src/main/resources/application-mysql.properties
sudo sed -i "s/3306/$master_port/g" src/main/resources/application-mysql.properties
sudo sed -i "s/9966/$backend_port/g" src/main/resources/application.properties
sudo sed -i "s/active=hsqldb/active=mysql/g" src/main/resources/application.properties

# Configure replication on master server
sudo mysql -u root -e "CREATE USER 'replication'@'%' IDENTIFIED BY 'password';"
sudo mysql -u root -e "GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
sudo sed -i "s/# server-id\t\t= 1/server-id\t\t= 1/g" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/# log_bin\t\t= \/var\/log\/mysql\/mysql-bin.log/log_bin\t\t= \/var\/log\/mysql\/mysql-bin.log/g" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Configure replication on slave server
sudo sed -i "s/# server-id\t\t= 2/server-id\t\t= 2/g" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/# relay_log\t\t= \/var\/log\/mysql\/relay-bin/relay_log\t\t= \/var\/log\/mysql\/relay-bin/g" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/# log_slave_updates\t= 0/log_slave_updates\t= 1/g" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
sudo mysql -u root -e "CHANGE MASTER TO MASTER_HOST='$master_ip', MASTER_PORT=$master_port, MASTER_USER='replication', MASTER_PASSWORD='password', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=0;"
sudo mysql -u root -e "START SLAVE;"

# Run backend
sudo ./mvnw spring-boot:run &
