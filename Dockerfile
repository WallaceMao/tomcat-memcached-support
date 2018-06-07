FROM registry-internal.cn-beijing.aliyuncs.com/rsq-public/tomcat:8.0.50-jre8

LABEL name="rishiqing-tomcat-memcached-support" \
       description="memcached supported tomcat" \
       maintainer="rishiqing group" \
       org="rishiqing"

ENV CATALINA_HOME /usr/local/tomcat
WORKDIR $CATALINA_HOME

COPY lib/memcached-session-manager-1.9.6.jar lib/
COPY lib/memcached-session-manager-tc8-1.9.6.jar lib/
COPY lib/msm-spymemcached-2.11.3.jar lib/

COPY bin/rsq-tomcat-start.sh bin/

CMD rsq-tomcat-start.sh 
