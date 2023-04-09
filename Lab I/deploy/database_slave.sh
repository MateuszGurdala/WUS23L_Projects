#!/bin/bash


SLAVE_PORT="$1"
MASTER_PORT="$2"
MASTER_ADDRESS="$3"

sudo apt update -y
sudo apt install -y mysql-server wget


echo "[mysqld]" | sudo tee -a /etc/mysql/my.cnf
echo "port=$SLAVE_PORT" | sudo tee -a /etc/mysql/my.cnf
echo "bind-address = localhost" | sudo tee -a /etc/mysql/my.cnf
echo "server-id = 1" | sudo tee -a /etc/mysql/my.cnf
sudo sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/3306/$SLAVE_PORT/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo chmod -R u+rwx /etc/mysql
sudo chown -R mysql.mysql /etc/mysql

sudo chown -R mysql /var/lib/mysql
sudo chgrp -R mysql /var/lib/mysql
sudo chmod 755 /var/lib/mysql


sudo chown -R mysql /var/log/mysql
sudo chgrp -R mysql /var/log/mysql
sudo chmod 755 /var/log/mysql
sudo chown -R mysql /var/log/mysql/error.log
sudo chgrp -R mysql /var/log/mysql/error.log
sudo chmod 755 /var/log/mysql/error.log

sudo mysql -e "CREATE USER 'slave'@'%' IDENTIFIED BY 'passwd'; GRANT ALL PRIVILEGES ON *.* TO 'slave'@'%' WITH GRANT OPTION;"
sudo mysql -e "CREATE USER 'pc'@'%' IDENTIFIED BY 'petclinic'; GRANT ALL PRIVILEGES ON *.* TO 'pc'@'%' WITH GRANT OPTION;"


wget "https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-rest/master/src/main/resources/db/mysql/initDB.sql"
wget "https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-rest/master/src/main/resources/db/mysql/populateDB.sql"

sudo mysql < initDB.sql
sudo mysql --database=petclinic < populateDB.sql

echo "{$MASTER_ADDRESS}:{$MASTER_PORT}"

sudo sed -i "s/.*server-id.*/server-id = 1/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/.*log_bin.*/log_bin = \\/var\\/log\\/mysql\\/mysql-bi.log/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo mysql -e "CHANGE MASTER TO MASTER_HOST='$MASTER_ADDRESS', MASTER_USER='replicate', MASTER_PASSWORD='passwd', MASTER_PORT=$MASTER_PORT;"
sudo mysql -e "FLUSH PRIVILEGES;"


sudo service mysql restart
sudo /etc/init.d/mysql start