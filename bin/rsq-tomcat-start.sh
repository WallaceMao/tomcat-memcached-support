#!/usr/bin/env bash

# check if user defined context.xml file exists in /etc/config/rishiqing/tomcat
context_file="/etc/config/rishiqing/tomcat/context.xml"
if [ -f "$context_file" ]; then
  cp -f $context_file $CATALINA_HOME/conf/context.xml
fi

# start tomcat 
$CATALINA_HOME/bin/catalina.sh run
