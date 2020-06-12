package com.lsy.code.database.utils;

import java.sql.Connection;
import java.sql.ParameterMetaData;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CustomDBUtils {

	public static void update(String sql,Object... params) {
		
		//获取连接
		Connection connection = JDBCUtils.getConnection();
		try {
			//获取执行对象
			PreparedStatement stmt = connection.prepareStatement(sql);
			ParameterMetaData metaData = stmt.getParameterMetaData();
			int count = metaData.getParameterCount();
			//设置参数
			for (int i = 1; i <= count; i++) {
				stmt.setObject(i, params[i-1]);
			}
			//执行sql
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
}
