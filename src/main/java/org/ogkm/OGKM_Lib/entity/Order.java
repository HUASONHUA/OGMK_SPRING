package org.ogkm.OGKM_Lib.entity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.Set;

public class Order { 
	private int id;	//PKey, Auto-increment 		 
	private Customer member; //required
	private LocalDate createdDate; //required	 
	private LocalTime createdTime=LocalTime.now(); //required
	 
	private String recipientName; //required	 
	private String recipientEmail; //required
	private String recipientPhone; //required	 
	private String shippingAddres; //required
	 
	private int status=0; //0:新訂單, 1:已轉帳, 2:已入帳, 3.已出貨,... 
	 
	private PaymentType paymentType; //required	 
	

	private double paymentFee;	 
	private String paymentNote;
	
	private DeliveryType deliveryType;	//required  
	private double deliveryFee;	 
	private String deliveryNote;
	
	private Set<OrderItem> orderItemSet=new HashSet<>(); //required 
	private double totalAmount;
	
	

	//orderItemSet's accessor
	public Set<OrderItem> getOrderItemSet(){
		return new HashSet<>(orderItemSet);
	}
	
	public int size() {
		return orderItemSet.size();
	}
public int getTotalQuantity() {
		int sum=0;
		for(OrderItem item:orderItemSet) {
			sum+=item.getQuantity();
		}
		return sum;
	}
public double getTotalAmount() {
	if(orderItemSet.size()>0) {
	double sum=0;
	for(OrderItem item:orderItemSet) {
		sum+=item.getPrice()*item.getQuantity();
	}
	return sum;
	}else {
		return this.totalAmount;
	}
}
public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
public double getTotalAmountWithFee() {
	double sum = getTotalAmount();
	sum +=paymentFee+deliveryFee;
	return Math.round(sum);
}


	//orderItemSet's mutator
	public void add(OrderItem item) {//for OrdersDAO: 查詢訂單明細後將orderItem記錄在order物件中
		orderItemSet.add(item);
	}
	
	public void add(ShoppingCart cart) { //for CheckoutServletOrdersDAO: 將cartItem轉為orderItem放order物件中
		if(cart==null || cart.isEmpty() ) {
			throw new IllegalArgumentException("結帳時購物車不能是NULL必須有明細");
		}
		for(Cartltem cartltem:cart.getCartItemSet()) {
			OrderItem orderItem=new OrderItem();
			orderItem.setProduct(cartltem.getProduct());
			orderItem.setTypecolor(cartltem.getTypecolor());
			orderItem.setSize(cartltem.getSize());
			orderItem.setPrice(cartltem.getProduct().getUnitPrice());
			orderItem.setQuantity(cart.getQuantity(cartltem));
		
			orderItemSet.add(orderItem);
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Customer getMember() {
		return member;
	}

	public void setMember(Customer member) {
		this.member = member;
	}

	public LocalDate getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}

	public LocalTime getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(LocalTime createdTime) {
		this.createdTime = createdTime;
	}

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getRecipientEmail() {
		return recipientEmail;
	}

	public void setRecipientEmail(String recipientEmail) {
		this.recipientEmail = recipientEmail;
	}

	public String getRecipientPhone() {
		return recipientPhone;
	}

	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}

	public String getShippingAddres() {
		return shippingAddres;
	}

	public void setShippingAddres(String shippingAddres) {
		this.shippingAddres = shippingAddres;
	}

	public int getStatus() {
		return status;
	}

	public String getStatusString() {
		return Status.getDescription(status);
	}
	
	public String getStatusString(int status) {
		return Status.getDescription(status);
	}
	
	public void setStatus(int status) {
		this.status = status;
	}

	public PaymentType getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(PaymentType paymentType) {
		this.paymentType = paymentType;
	}

	public double getPaymentFee() {
		return paymentFee;
	}

	public void setPaymentFee(double paymentFee) {
		this.paymentFee = paymentFee;
	}

	public String getPaymentNote() {
		return paymentNote;
	}

	public void setPaymentNote(String paymentNote) {
		this.paymentNote = paymentNote;
	}

	public DeliveryType getDeliveryType() {
		return deliveryType;
	}

	public void setDeliveryType(DeliveryType deliveryType) {
		this.deliveryType = deliveryType;
	}

	public double getDeliveryFee() {
		return deliveryFee;
	}

	public void setDeliveryFee(double deliveryFee) {
		this.deliveryFee = deliveryFee;
	}

	public String getDeliveryNote() {
		return deliveryNote;
	}

	public void setDeliveryNote(String deliveryNote) {
		this.deliveryNote = deliveryNote;
	}
	
	@Override
	public String toString() {
		return "訂單編號=" + id 
				+ "\n 訂購人:" + member 
				+ "\n 訂購日期" + createdDate 
				+ "\n 訂購時間" + createdTime
				+ "\n 收件人性名:" + recipientName 
				+ "\n 收件人郵箱:" + recipientEmail 
				+ "\n 收件人電話:"+ recipientPhone 
				+ "\n 收件人地址: " + shippingAddres 
				+ "\n 狀態:" + status 
				+ "\n 付款方式:"+ paymentType 
				+ "\n 付款費用:" + paymentFee 
				+ "\n 付款資訊:" + paymentNote 
				+ "\n 取貨方式:"+ deliveryType 
				+ "\n 取貨費用" + deliveryFee 
				+ "\n 取貨資訊" + deliveryNote 
				+ "\n "+ orderItemSet 
				+ "\n 項數:" + size() 
				+ "\n 件數:" + getTotalQuantity()
				+ "\n 價格" + getTotalAmount() 
				+ "\n 總價格(手續費)" + getTotalAmountWithFee();
	}
	
	public enum Status{
		NEW("新訂單"),TRANSFORED("已轉帳"),PAID("已入帳"),
		SHIPPED("已出貨"),ARRIVED("已到貨"),CHECKED("已簽收"),COMPLETE("完結");
		
		private final String description;

		private Status(String description) {
			this.description = description;
		}

		public String getDescription() {
			return description;
		}
		
		public static String getDescription(int status) {
			if(status>=0 && status<values().length)
				return values()[status].getDescription();
			else {
				return String.valueOf(status);
			}
		}
	}
}
 
