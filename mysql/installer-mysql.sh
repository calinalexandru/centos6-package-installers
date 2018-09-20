#!/usr/bin/env bash
clear

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

/usr/bin/mysqladmin -u root password $PASSWORD1

