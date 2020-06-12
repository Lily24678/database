package com.lsy.code.database;

import java.io.PrintWriter;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.sql.DataSource;

import com.lsy.code.database.utils.JDBCUtils;
/**
 * 自定义连接池 实现javax.sql.DataSource;动态代理实现增强Connection的close方法
 */
public class CustomPool implements DataSource {
	private static List<Connection> poollist = new ArrayList<Connection>();
	static {
		for (int i = 0; i < 5; i++) {
			Connection connection = JDBCUtils.getConnection();
			poollist.add(connection);
		}
	}

	@Override
	public Connection getConnection() throws SQLException {
		if (poollist.size() > 0) {
			Connection connection = poollist.remove(0);
			Connection newProxyInstance = (Connection) Proxy.newProxyInstance(Connection.class.getClassLoader(),
					new Class[] { Connection.class }, new InvocationHandler() {
						@Override
						public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
							if ("close".equals(method.getName())) {
								poollist.add(connection);
							} else {
								return method.invoke(connection, args);
							}
							return null;
						}
					});
			return newProxyInstance;
		}
		return null;
	}

	
	
	@Override
	public PrintWriter getLogWriter() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setLogWriter(PrintWriter out) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void setLoginTimeout(int seconds) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public int getLoginTimeout() throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Logger getParentLogger() throws SQLFeatureNotSupportedException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public <T> T unwrap(Class<T> iface) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isWrapperFor(Class<?> iface) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Connection getConnection(String username, String password) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}