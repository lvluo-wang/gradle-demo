#!bin/sh

filename=/app.jar

if [ -n "$filename" ];then
   echo "$filename running...";
   java -jar $filename
else
   echo "can't find executable file"
fi