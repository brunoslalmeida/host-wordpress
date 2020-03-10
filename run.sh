#!/bin/bash
if test -z "$1" 
then
  echo "Missing Server Name"
  exit -1
fi

pwd=$(pwd)
cwd=$(pwd)/site/$1
name=wordpress_$1

if ! test -d "$pwd/wordpress"; 
then
  wget https://wordpress.org/latest.tar.gz
  tar -zxvf latest.tar.gz
  rm -rf latest.tar.gz
fi

if ! test -d "$cwd";
then 
  mkdir -p $cwd
  cp -R $pwd/wordpress $cwd
fi

docker stop $name
docker rm nginx $name

docker run -d \
  --name $name \
  --hostname $name \
  --restart=always \
  --network internal \
  -v $cwd/wordpress:/var/www/html \
  wordpress
