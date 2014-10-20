#!/bin/bash

set -u
set -e

MYSQL_PKG=$1
MYSQL_PWD=$2
MYSQL_NEW_DB=$3
MYSQL_NEW_USR=$4
MYSQL_NEW_USR_PWD=$5


echo "installing $MYSQL_PKG"

echo "$MYSQL_PKG mysql-server/root_password password $MYSQL_PWD" | sudo debconf-set-selections
echo "$MYSQL_PKG mysql-server/root_password_again password $MYSQL_PWD" | sudo debconf-set-selections

apt-get install -q -y $MYSQL_PKG libmysqlclient-dev expect

echo "mysql secure setup"
expect -c "
set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_PWD\r\"

expect \"Change the root password?\"
send \"n\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
"

echo "setting up new db [$MYSQL_NEW_DB] for [$MYSQL_NEW_USR]"

mysql -u root --password=$MYSQL_PWD <<EOF
SET storage_engine=INNODB;
CREATE DATABASE IF NOT EXISTS \`$MYSQL_NEW_DB\` DEFAULT CHARACTER SET \`utf8\` COLLATE \`utf8_unicode_ci\`;
GRANT ALL PRIVILEGES ON \`$MYSQL_NEW_DB\`.* TO \`$MYSQL_NEW_USR\`@\`localhost\` IDENTIFIED BY "$MYSQL_NEW_USR_PWD";
SET PASSWORD FOR \`$MYSQL_NEW_USR\`@\`localhost\` = PASSWORD("$MYSQL_NEW_USR_PWD");
FLUSH PRIVILEGES;
EOF
