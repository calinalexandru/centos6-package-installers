#!/usr/bin/env bash

PASSWORD1=''
PASSWORD2=''

password_prompt() {
  echo -n "Enter root mysql password: "
  stty -echo
  read -r PASSWORD1
  echo
  echo -n "Retype password: "
  read -r PASSWORD2
  stty echo
  echo
  if [ "$PASSWORD1" != "$PASSWORD2" ]; then
    echo "Passwords do not match!"
  fi
}

while : ; do
    password_prompt
    [[ "$PASSWORD1" != "$PASSWORD2" ]] || break
done

# install package
yum -y install mysql-server

# start service
service mysqld start

# set root passwd
mysqladmin -u root password $PASSWORD1

# boot
chkconfig mysqld on

# info
mysql -V
