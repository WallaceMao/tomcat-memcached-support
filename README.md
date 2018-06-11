# tomcat-memcached-support
兼容memcached session共享的docker镜像

# usage

1. 基于该tomcat镜像构建应用镜像，注意Dockerfile中如果需要使用CMD指令，那么CMD指令应该为：`CMD rsq-tomcat-start.sh`
2. 应用镜像中需要指定tomcat的context.xml配置文件，并mount到`/etc/config/rishiqing/tomcat/`目录下，`rsq-tomcat-start.sh`启动时，会自动查找是否有`/etc/config/rishiqing/tomcat/context.xml`文件，如果存在，那么会覆盖tomcat中conf目录下的context.xml文件。

# context.xml示例

1. non-sticky session

```
<?xml version='1.0' encoding='utf-8'?>
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>
    <Manager 
      className="de.javakaffee.web.msm.MemcachedBackupSessionManager"  
      memcachedNodes="n1:127.0.0.1:11211,n2:127.0.0.1:11212"
      sticky="false"
      sessionBackupAsync="false"
      lockingMode="all"
      requestUriIgnorePattern=".*\.(ico|png|gif|jpg|css|js)$"  
      transcoderFactoryClass="de.javakaffee.web.msm.JavaSerializationTranscoderFactory"  
    />
</Context>
```

2. sticky session

```
<?xml version='1.0' encoding='utf-8'?>
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>
    <Manager
      className="de.javakaffee.web.msm.MemcachedBackupSessionManager"
      memcachedNodes="ttm-memcached.ttm-beta.svc.cluster.local:11211"
      requestUriIgnorePattern=".*\.(ico|png|gif|jpg|css|js)$"
      sessionBackupAsync="false"
      sessionBackupTimeout="2000"
      transcoderFactoryClass="de.javakaffee.web.msm.JavaSerializationTranscoderFactory"
    />
</Context>

```
