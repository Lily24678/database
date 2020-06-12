package com.lsy.code.database.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCUtils {
	private static Connection connection;
	private static String driverName;
	private static String url;
	private static String user;
	private static String password;
	static {
		readConfig("config/database.properties");
		try {
			//1、注册驱动。告知JVM使用的是哪一个数据库的驱动
			Class.forName(driverName);
			//2、获得连接。使用JDBC中的类,完成对MySQL数据库的连接
			connection = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @return 获取java.sql.Connection;
	 */
	public static Connection getConnection() {
		return connection;
	}
	
	/**
	 * 释放与数据库相关资源
	 * @param connection {@link}java.sql.Connection;
	 * @param statement {@link}java.sql.ResultSet;
	 * @param resultSet {@link}java.sql.Statement;
	 */
	public static void closeQuietly(Connection connection,Statement statement,ResultSet resultSet) {
		if (null!=resultSet) {
			try {
				resultSet.close();
			} catch (SQLException e) {
				//quiet
			}
		}
		if (null!=statement) {
			try {
				statement.close();
			} catch (SQLException e) {
				//quiet
			}
		}
		if (null!=connection) {
			try {
				connection.close();
			} catch (SQLException e) {
				//quiet
			}
		}
		
	}
	
	/**
	 * 加载配置文件
	 * @param fileName
	 */
	private static void readConfig(String fileName) {
		InputStream is = JDBCUtils.class.getClassLoader().getResourceAsStream(fileName);
		Properties properties = new Properties();
		try {
			properties.load(is);
			driverName = properties.getProperty("driverName");
			url = properties.getProperty("url");
			user = properties.getProperty("user");
			password = properties.getProperty("password");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
