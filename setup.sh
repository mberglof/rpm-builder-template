#!/bin/bash

usage () {
    echo "$0 -n project-name -d 'short project desc' -v version -r rpm-name"
    exit 1
}

#[ "$#" -lt 1 ] && usage 
#DESC=Lua 5.3.x
#RPMNAME=lua53

while getopts "hn:d:v:r:" opt; do
  case $opt in
    n)
	  PROJECT_NAME=$OPTARG
      #echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    d)
	  PROJECT_DESC=$OPTARG
      #echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    v)
	  PROJECT_VERSION=$OPTARG
      #echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    r)
	  PROJECT_RPM_NAME=$OPTARG
      #echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
    h|*) 
      usage
      ;;
  esac
done

PROJECT_NAME=${PROJECT_NAME:=${PWD##*/}}
PROJECT_DESC=${PROJECT_DESC:=${PROJECT_NAME} ${PROJECT_VERION}}
PROJECT_VERSION=${PROJECT_VERSION:=0.0.0}
PROJECT_RPM_NAME=${PROJECT_RPM_NAME:=${PROJECT_NAME} ${PROJECT_VERSION}}

echo "Will setup RPM build project with the following values"

for VAR in $(echo ${!PROJ*}); do echo $VAR=${!VAR} ; done
echo "Continue? (y/n)"

read ANSWER

case $ANSWER in
    n|[n|N][O|o])
        exit 1
        ;;
    y|[Y|y][E|e][s|S])
        echo ok
        ;;
    *)
        echo pfft
        ;;
esac

export IMGNAME=${PROJECT_NAME}

echo "Creating docker_wrapper.sh for $IMGNAME"
envsubst '$IMGNAME' < templates/docker_wrapper.sh > docker_wrapper.sh

echo "Creating Makefile for $IMGNAME"
envsubst '$IMGNAME' < templates/Makefile > Makefile

echo "Creating build.sh for $IMGNAME"
envsubst '$PROJECT_NAME:$PROJECT_DESC:$PROJECT_RPM_NAME:$PROJECT_VERSION' < templates/build.sh > scripts/build.sh

echo Creating .envrc from ~/config/copr
source env.sh > .envrc
