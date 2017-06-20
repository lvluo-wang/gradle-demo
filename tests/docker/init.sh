#!/bin/sh

PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done


ROOT=`dirname "$PRG"`
ROOT=`cd "$ROOT";pwd`

if [ ! -d "$ROOT/lib" ]; then
  mkdir "$ROOT/lib"
fi

if [ ! -d "$ROOT/log" ]; then
  mkdir "$ROOT/log"
fi

API=`cd "$ROOT/../..";pwd`

echo $API


  if [ -z "$1" -o "$1" = "api" ]; then
  cd "$API"

  gradle clean
  gradle build

  apifile=$API/build/libs/gradle-demo-0.1.0.jar

 echo $apifile
  if [ -z "`which gradle`" ]; then
    echo "gradle not found"
    exit 1
  fi

  if [ ! -f "$apifile" ]; then
    echo "war/jar build failed"
    exit 1
  fi

  cp -v "$apifile" "$ROOT/lib"
fi