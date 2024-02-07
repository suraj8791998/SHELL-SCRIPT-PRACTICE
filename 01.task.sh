#    CHECK PACKAGE IS INSTALLED OR NOT
#    IF NOT INSTALLED THEN IT SHOULD INSTALLED
#    OR ELSE IT SHOULD PRINT PACKAGE IS ALREADY INSTALLED
#    STORE THE LOG MESSAGES IN LOG FILE

#!/bin/bash

DATE=$(date +%F)
SCRIPT_NAME=$0
LOGS_DIR=/home/centos/tmp/
LOGFILE=$LOGS_DIR/$0-$DATE.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then
      echo "PACKAGE INSTALLATION IS SUCCESS"
    else
      echo "PACKAGE INSTALLATION IS FAILURE"
    fi
}

USERID=(id -u)
if [ $USERID -ne 0 ]
then 
   echo "PLEASE SWITCH TO THE ROOT USER"
   exit 1
else 
   echo "YOU ARE IN ROOT USER"
fi 

for i in $@
do
  yum list installed i &>>$LOGFILE
  if [ $? -ne 0 ]
  then
    echo "PACKAGE IS NOT YET INSTALLED, LETS INSTALL IT"
    yum install $i -y &>>$LOGFILE
    VALIDATE $? $i
  else
    echo "PACKAGE IS INSTALLED ALREADY"
  fi
done
