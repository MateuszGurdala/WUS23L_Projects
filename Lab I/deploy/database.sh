port=$1

cd /root
sudo apt update
sudo apt upgrade -y
sudo apt install -y mysql-server

echo "[mysqld]" | sudo tee -a /etc/mysql/my.cnf
echo "port=$port" | sudo tee -a /etc/mysql/my.cnf
echo "bind-address = 0.0.0.0" | sudo tee -a /etc/mysql/my.cnf
echo "server-id = 1" | sudo tee -a /etc/mysql/my.cnf
echo "log_bin = /var/log/mysql/mysql-bin.log" | sudo tee -a /etc/mysql/my.cnf

sudo service mysql restart
sudo service mysql start
# sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo mysql -e "CREATE USER IF NOT EXISTS 'pc'@'%' IDENTIFIED BY 'petclinic';"



wget https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-rest/master/src/main/resources/db/mysql/initDB.sql
sed -i "s/GRANT ALL PRIVILEGES ON petclinic.* TO pc@localhost IDENTIFIED BY 'pc';/GRANT ALL PRIVILEGES ON petclinic.* TO 'pc'@'%' WITH GRANT OPTION;/g" ./initDB.sql
cat initDB.sql | sudo mysql -f

wget https://raw.githubusercontent.com/spring-petclinic/spring-petclinic-rest/master/src/main/resources/db/mysql/populateDB.sql
sed -i '1 i\USE petclinic;' ./populateDB.sql
cat populateDB.sql | sudo mysql -f

sudo mysql -v -e "UNLOCK TABLES;"

