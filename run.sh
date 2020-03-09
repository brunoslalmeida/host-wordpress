#!/bin/bash
if test -z "$1" 
then
  echo "Missing Server Name"
  exit -1
fi

cwd=$(pwd)/site/$1
name=wordpress_$1

docker stop $name
docker rm nginx $name

docker run -d \
  --name $name \
  --hostname $name \
  --restart=always \
  --network internal \
  -v $cwd/themes:/var/www/html/wp-content/themes \
  -v $cwd/plugins:/var/www/html/wp-content/plugins \
  -v $cwd/uploads:/var/www/html/wp-content/uploads \
  wordpress
