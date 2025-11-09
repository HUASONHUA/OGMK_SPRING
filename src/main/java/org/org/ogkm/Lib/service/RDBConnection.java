package org.org.ogkm.Lib.service;

import org.org.ogkm.Lib.exception.OGKMException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class RDBConnection {
	private static final  String driver="com.mysql.cj.jdbc.Driver";
	private static final  String url="jdbc:mysql://localhost:3306/ogk";
	private static final  String userId="root";
	private static final  String pwd="ROOT";

	static Connection getConnection() throws OGKMException {
		
		try {
			Class.forName(driver);
			try {
				Connection connection=DriverManager.getConnection(url,userId,pwd);
			    return connection;
			} catch (SQLException e) {
				throw new OGKMException("建立連線失敗",e);
			}
		} catch (ClassNotFoundException e) {
		
			throw new OGKMException("載入driver失敗:"+driver);
		}
	}		
}
