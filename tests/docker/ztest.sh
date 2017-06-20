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
DOCKER=`cd "$ROOT";pwd`
ROOT=`cd "$DOCKER/..";pwd`

FIRST="$1"
if [ -z "$FIRST" ]; then
  FIRST="help"
fi

checkDocker(){
  if [ "`which docker-compose`" = "" ]; then
    echo "docker-compose not found"
    exit 1
  fi
  }


cd "$DOCKER"

case "$FIRST" in
up)
    checkDocker && docker-compose $@
  ;;
down)
    checkDocker && docker-compose $@
  ;;
refresh)
    shift 1
    case "$1" in
      api)
        "$DOCKER/init.sh" api
      ;;
      *)
        echo "请指定刷新参数!"
        exit 1
      ;;
    esac
  ;;
*)
  cat <<EOF
Usage: ztest CMD [OPTION]
    ztest up [-d] [dcname]         启动
    ztest down                     关闭
    ztest refresh [api]            初始化

EOF
;;
esac