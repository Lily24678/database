package com.lsy.code.database.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * tomcat 内置连接池
 */
public class TomcatBuildInPoolUtils {
	private static DataSource dataSource;
	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			dataSource = (DataSource) envCtx.lookup("tomcatpool"); // context.xml配置中
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
			e.getSuppressed();
		}
		return connection;
	}
	/**
	 * 释放与数据库相关资源
	 * @param connection {@link}java.sql.Connection;
	 * @param statement {@link}java.sql.ResultSet;
	 * @param resultSet {@link}java.sql.Statement;
	 */
	public static void release(Connection connection,Statement statement,ResultSet resultSet) {
		if (null!=resultSet) {
			try {
				resultSet.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (null!=statement) {
			try {
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (null!=connection) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
}
