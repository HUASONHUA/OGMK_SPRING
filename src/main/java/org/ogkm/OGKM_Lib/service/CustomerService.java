package org.ogkm.OGKM_Lib.service;

import org.ogkm.OGKM_Lib.entity.Customer;
import org.ogkm.OGKM_Lib.exception.LoginFailException;
import org.ogkm.OGKM_Lib.exception.OGKMException;

public class CustomerService {
 private CustomersDAO dao= new CustomersDAO();
	
	public Customer login(String id, String password) throws OGKMException {
		if(id==null||id.length()==0||
				password==null||password.length()==0) {
			throw new IllegalArgumentException("必須輸入帳號或密碼");
		}
			
		Customer c =dao.selectCustomerById(id);
		if(c!=null && c.getPassword()!=null&&
				c.getPassword().equals(password)) {
			return c;
		}
		throw new LoginFailException("登入失敗,帳號密碼不正確");
	}
	
	public void register(Customer c)  throws OGKMException{
		if(c==null) {
			throw new IllegalArgumentException("新增客戶時CUSTOMER不能為NULL");
		}
			dao.insert(c);
	}
	
	public void update(Customer c)throws OGKMException {
		if(c==null) {
			throw new IllegalArgumentException("修改客戶時customer物件不得為null");
		}
		dao.update(c);
	}
	
	
	
}
