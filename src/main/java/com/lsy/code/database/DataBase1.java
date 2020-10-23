package com.lsy.code.database;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.junit.Test;

import com.lsy.code.database.domain.User;
import com.lsy.code.database.utils.JDBCUtils;
/**
 * JDBC 的基础开发步骤。用commons-dbutils-xx.jar操作数据库
 */
public class DataBase1 {
	@Test
	public void operatByJDBC(){
		try {
			
			//1. 	注册驱动。告知JVM使用的是哪一个数据库的驱动
//			@deprecated Class.forName("com.mysql.jdbc.Driver");
			Class.forName("com.mysql.cj.jdbc.Driver");
			//2. 	获得连接。使用JDBC中的类,完成对MySQL数据库的连接
//			DriverManager.registerDriver(driver);不推荐，原因重复注册驱动
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/store?serverTimezone=GMT%2B8", "root", "root");
			//3.	获得语句执行平台：通过连接对象获取对SQL语句的执行者对象
			String sql = "SELECT * FROM user LIMIT ?,?";
			//conn.createStatement();不推荐，会有sql注入问题
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setLong(1, 0);//parameterIndex 从1开始
			statement.setLong(2, 1);//parameterIndex 从1开始
			//4.	执行sql语句。使用执行者对象,向数据库执行SQL语句，获取到数据库的执行后的结果
			ResultSet resultSet = statement.executeQuery();
			//5.	处理结果。
			while (resultSet.next()) {
				System.out.println(resultSet.getString("uid")+"\t"+resultSet.getString("username")+"\t"+resultSet.getString("password"));
			}
			//6.	释放资源。释放与操作数据库相关的资源 一堆close()
			resultSet.close();
			statement.close();
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void operatByDBUtils() {
		//获取连接
		Connection connection = JDBCUtils.getConnection();
	
		//操作数据库
		String sql_query = "SELECT * FROM user LIMIT ?,?";
		QueryRunner runner = new QueryRunner();
		try {
			List<User> list = runner.query(connection, sql_query, new ResultSetHandler<List<User>>() {

				@Override
				public List<User> handle(ResultSet rs) throws SQLException {
					
					ResultSetMetaData metaData = rs.getMetaData();//获取ResultSet的元数据
					
					int count = metaData.getColumnCount();
					List<User> list = new ArrayList<User>();
					while (rs.next()) {
						User user = new User();
						for (int i = 1; i <= count; i++) {
							setPropertyQuietly(user,metaData.getColumnLabel(i),rs.getObject(metaData.getColumnLabel(i)));
						}
						list.add(user);
					}
					DbUtils.closeQuietly(rs);
					return list;
				}

			}, 0,10);
			DbUtils.closeQuietly(connection);
			System.out.println(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	private void setPropertyQuietly(Object bean,String name,Object value) {
		try {
			Class<? extends Object> clazz = bean.getClass();
			Field field = clazz.getDeclaredField(name);//获取私有字段
			field.setAccessible(true);//将private 修改为public
			field.set(bean, value);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
