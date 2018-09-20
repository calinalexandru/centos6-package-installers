#!/usr/bin/env bash

echo "Exec apache install script->"
./apache/install-apache.sh

echo "Exec php install script->"
./php/install-php.sh

echo "Exec mysql install script->"
./mysql/install-mysql.sh
