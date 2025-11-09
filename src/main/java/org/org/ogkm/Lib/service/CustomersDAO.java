package org.org.ogkm.Lib.service;

import org.ogkm.Lib.entity.Customer;
import org.ogkm.Lib.entity.VIP;
import org.org.ogkm.Lib.exception.DataInvalidException;
import org.org.ogkm.Lib.exception.OGKMException;

import java.sql.*;
public class CustomersDAO {
	private static final  String SelectCustomer=
			"SELECT id,name,email,password,birthday,gernder,"
			+"address,address1,phone,subscribed,discount,isAdmin "
			+"FROM customers WHERE id=? OR email=?";
	Customer selectCustomerById(String id) throws OGKMException{
		Customer c =null;
		
		try (Connection connection= RDBConnection.getConnection();//取得連線
				PreparedStatement pstmt=connection.prepareStatement(SelectCustomer);
			){
				pstmt.setString(1, id);
				pstmt.setString(2, id);
				
			try (ResultSet rs= pstmt.executeQuery();//執行指令
				){
					 while (rs.next()) {//處理rs
					 int discount=rs.getInt("discount");
						 if(discount>0) {
							 c=new VIP();
							 ((VIP)c).setDiscount(discount);	 
						 }else
						     c= new Customer();
						 
						c.setId(rs.getString("id"));
						c.setName(rs.getString("name"));
						c.setEmail(rs.getString("email"));
						c.setPassword(rs.getString("password"));
						c.setBirthday(rs.getString("birthday"));
						c.setGender(rs.getString("gernder").charAt(0));
						c.setAddress(rs.getString("address"));
						c.setAddress1(rs.getString("address1"));
						c.setPhone(rs.getString("phone"));
						c.setSubscribed(rs.getBoolean("subscribed"));
						c.setAdmin(rs.getBoolean("isAdmin"));
					 }	
				}
			} catch (SQLException e) {	
				throw new OGKMException("用帳號查詢客戶失敗",e);
			}
		return c;
	}
	private static final String INSERTCustomer="INSERT INTO customers"
           +"(id,name,email,password,birthday,gernder,"
           +"address,address1,phone,subscribed,isAdmin)"
		   +"VALUES(?,?,?,?,?,?,?,?,?,?,?)";
	void insert(Customer c) throws OGKMException {
		
		try (Connection connection = RDBConnection.getConnection();//1.2.取得連線
			PreparedStatement pstmt=connection.prepareStatement(INSERTCustomer);//3.準備指令
				){
			pstmt.setString(1, c.getId());
			pstmt.setString(2, c.getName());
			pstmt.setString(3, c.getEmail());
			pstmt.setString(4, c.getPassword());
			pstmt.setString(5, c.getBirthday().toString());
			pstmt.setString(6, String.valueOf(c.getGender()));
			pstmt.setString(7, c.getAddress());
			pstmt.setString(8, c.getAddress1());
			pstmt.setString(9, c.getPhone());
			pstmt.setBoolean(10, c.isSubscribed());
			pstmt.setBoolean(11, c.isAdmin());
				
			int rows=pstmt.executeUpdate();//執行指令
			//System.out.println(rows);
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getErrorCode()+","+e.getMessage());
			if(e.getMessage().indexOf("PRIMARY")>0) {
			throw new DataInvalidException("帳號重複",e);
			}else if(e.getMessage().indexOf("email_UNIQUE")>0){
				throw new DataInvalidException("email重複",e);
			}else {
				throw new OGKMException("新增客戶失敗,請查看缺失欄位",e);
			}
		}catch (SQLException e) {
			throw new OGKMException("新增客戶失敗",e);
		}
	}	
	
	private static final  String UpdataSelectCustomer="UPDATE customers SET "
			+"name=?,email=?,password=?,birthday=?,gernder=?,address=?,"
			+"address1=?,phone=?,subscribed=? WHERE id=?";
	void update(Customer c) throws OGKMException {
		try (
				Connection connection = RDBConnection.getConnection();//1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(UpdataSelectCustomer); //3.準備指令
				) {
			//3.1傳入?的值
				
				pstmt.setString(1, c.getName());
				pstmt.setString(2, c.getEmail());
				pstmt.setString(3, c.getPassword());
				pstmt.setString(4, c.getBirthday().toString());
				pstmt.setString(5, String.valueOf(c.getGender()));
				pstmt.setString(6, c.getAddress());
				pstmt.setString(7, c.getAddress1());
				pstmt.setString(8, c.getPhone());
				pstmt.setBoolean(9, c.isSubscribed());
				pstmt.setString(10, c.getId());
				
				
				int rows = pstmt.executeUpdate();//4.執行指令
				//System.out.println(rows); //for test	
		}catch(SQLIntegrityConstraintViolationException e) {
			System.out.println(e.getErrorCode()+","+e.getMessage());
			if(e.getMessage().indexOf("PRIMARY")>0) {
				throw new DataInvalidException("帳號已重複註冊", e);
			}else if(e.getMessage().indexOf("email_UNIQUE")>0) {
				throw new DataInvalidException("email已重複註冊", e);
			}else  {
				throw new OGKMException("修改客戶失敗，欄位不得為null", e);
			}
		}catch (SQLException e) {					
			throw new OGKMException("修改客戶失敗", e);
		}
		
	}	
}
