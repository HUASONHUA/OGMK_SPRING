package org.ogmk.Lib.entity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.ogkm.exception.DataInvalidException;

public class ShoppingCart {
	

	private Customer member;
	private Map<Cartltem, Integer> cartMap=new HashMap<>();
	
	public Customer getMember() {
		return member;
	}
	public void setMember(Customer member) {
		this.member = member;
	}
	//assess(s) for cartMap:add , update,remove
	public int size() {
		return cartMap.size();
	}
	public boolean isEmpty() {//可以用size()==0 取代方法
		return cartMap.isEmpty();
	}
	public Set<Cartltem> getCartItemSet() {
		//回傳集合元件時不能傳原本的參考物件，必須回傳副本參考物件
//	方法之一 return Collections.unmodifiableSet(cartMap.keySet());
		return new HashSet<>(cartMap.keySet());
	}
//	public Collection<Integer> values() {
//		return cartMap.values();
//	}
	
	
	public int getQuantity(Cartltem item) {
		Integer quantity=cartMap.get(item);
		return quantity==null?0:quantity;
	}
	public int getTotalQuantity() {
		int sum =0;
		for (Integer quantity:cartMap.values()) {
			if(quantity!=null) {
				sum+=quantity;
			}
		}
		return sum;
	}
	
	public double getTotalAmount() {
		double sum =0;
		for (Cartltem item:cartMap.keySet()) {
			double price =item.getProduct().getUnitPrice();
			Integer qty=cartMap.get(item);
			if(qty!=null) {
				sum+=price*qty;
			}
		}
		return sum;
	}
	
	//mutator(s) for cartMap:add , update,remove
	public void addTOCart(Product product,String typecolorname,
			Size size,int quantity ) {
		if (product==null) {
			throw new IllegalArgumentException("加入購物車不能為NULL");
		}
		TypeColor typecolor=null;
		if (typecolorname!=null ) {
			typecolor=product.getTypecolor(typecolorname);
		}
		if(!product.isTypecolorMapEmpty() && typecolor==null) {
			throw new DataInvalidException("產品顏色不正確");
		}
		//TODO:檢查前端傳入的typecolorname與後端產品清單對應是否正確
		/*
		 else if(){}
		 */
	
	if(quantity<=0) throw new IllegalArgumentException("加入購物車數量不能為0");
	
	Cartltem item=new Cartltem();
	item.setProduct(product);
	item.setTypecolor(typecolor);
	item.setSize(size);
	
	//找出之前是否有加入相同 資料 的產品數量
	Integer oidQuantity =cartMap.get(item);
	if(oidQuantity!=null) {
		quantity+=oidQuantity;
	}
	cartMap.put(item, quantity);
	
	}
	
	public void updateCart(Cartltem item,int quantity ) {
		if (item==null ) {
			throw new IllegalArgumentException("修改購物車不能為NULL");	
		}
		//找出之前是否加入相同的(product, colorName, size)產品的數量
				Integer oldQuantity = cartMap.get(item);
				if(oldQuantity!=null) {		
					cartMap.put(item, quantity);
				}
	}
	
	public void remove(Cartltem item) {
		cartMap.remove(item);
	}

	public void remove() {
		cartMap.clear();
	}
	
	
	@Override
	public String toString() {
		return "\n"+this.getClass().getSimpleName()
				+"\n 訂購人:"+member
				+"\n 購物車:"+cartMap
				+"\n 共:"+size()+"項"+getTotalQuantity()+"件"
				+"\n 總價:"+getTotalAmount();
	}
	
	
}
