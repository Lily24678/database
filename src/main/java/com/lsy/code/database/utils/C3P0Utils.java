package com.lsy.code.database.utils;

import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0Utils {
	private static ComboPooledDataSource dataSource = new ComboPooledDataSource();//据源代码：默认加载c3p0-config.xml

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
