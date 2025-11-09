package org.ogkm.Lib.entity;

public enum PaymentType {
	CREDIT_CARDPAYMENT("信用卡"),
	SUPERMARKET("超商付款",30),
	ATM("ATM轉帳");

	private final String paymendescription;
	private final double fee;
	
	private PaymentType(String paymendescription) {
		this(paymendescription,0);
	}

	private PaymentType(String paymendescription, double fee) {
		this.paymendescription = paymendescription;
		this.fee = fee;
	}

	public String getPaymendescription() {
		return paymendescription;
	}

	public double getFee() {
		return fee;
	}

	@Override
	public String toString() {
		return paymendescription+(fee>0?" 手續費"+fee+"元":"");
	}

	
}
