#!/bin/bash
set -e

chown -R mysql:mysql /var/lib/mysql
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

service mysqld start

tfile=`mktemp`
cat << EOF > $tfile
GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION; 
FLUSH PRIVILEGES;
EOF

if [[ $MYSQL_DATABASE != "" ]]; then
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [[ $MYSQL_USER != "" ]]; then
        echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
    fi
fi
echo "init db"
mysql -e"source $tfile"
rm -f $tfile
echo "start mysql succ"
tail /dev/stdout
forego start -r
echo 'stop mysql'
service mysqld stop
echo "stop mysql succ"
