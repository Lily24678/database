#  数据库(package:database)
## JDBC规范
- java.sql.DriverManager;
- commons-dbutils-xx.jar(org.apache.commons.dbutils.QueryRunner;org.apache.commons.dbutils.ResultSetHandler;)


```
<!-- https://mvnrepository.com/artifact/commons-dbutils/commons-dbutils -->
<dependency>
    <groupId>commons-dbutils</groupId>
    <artifactId>commons-dbutils</artifactId>
    <version>1.7</version>
</dependency>
```

## 数据库连接池
### javax.sql.DataSource;

### tomcat 内置连接连接池（DBCP）的配置使用 JNDI

### DBCP (commons-dbcp-xx.jar,commons-pool-xxx.jar)
```
<!-- https://mvnrepository.com/artifact/commons-dbcp/commons-dbcp -->
<dependency>
    <groupId>commons-dbcp</groupId>
    <artifactId>commons-dbcp</artifactId>
    <version>1.4</version>
</dependency>
```
org.apache.commons.dbcp.BasicDataSourceFactory;

### c3p0：https://www.mchange.com/projects/c3p0/(c3p0-0.9.1.2.jar)
```
<!-- https://mvnrepository.com/artifact/c3p0/c3p0 -->
<dependency>
    <groupId>c3p0</groupId>
    <artifactId>c3p0</artifactId>
    <version>0.9.1.2</version>
</dependency>
```
- com.mchange.v2.c3p0.ComboPooledDataSource;

### 自定义连接池（CustomPool）


# XML 文档解析
- com.lsy.code.xml.Dom4j1.java
### dom4j(dom4j-xxx.jar)
```
<!-- https://mvnrepository.com/artifact/dom4j/dom4j -->
<dependency>
    <groupId>dom4j</groupId>
    <artifactId>dom4j</artifactId>
    <version>1.6.1</version>
</dependency>
```
### XPath 表达式(jaxen-xxx-beta-xxx.jar)
```
<!-- https://mvnrepository.com/artifact/jaxen/jaxen -->
<dependency>
          <groupId>jaxen</groupId>
          <artifactId>jaxen</artifactId>
          <version>1.2.0</version>
</dependency>
```
