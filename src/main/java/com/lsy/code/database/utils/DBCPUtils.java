package com.lsy.code.database.utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

/**
 * 连接池：DBCP
 */
public class DBCPUtils {
	private static DataSource dataSource;
	static {
		Properties properties = new Properties();
		try {
			properties.load(DBCPUtils.class.getClassLoader().getResourceAsStream("config/database.properties"));
			dataSource = BasicDataSourceFactory.createDataSource(properties);
		} catch (Exception e) {
			throw new ExceptionInInitializerError(e);
		}
	}

	/**
	 * @return 获取java.sql.Connection;
	 */
	public static Connection getConnection() {
		Connection connection = null;
		try {
			connection = dataSource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}
}
