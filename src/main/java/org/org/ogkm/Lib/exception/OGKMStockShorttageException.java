package org.org.ogkm.Lib.exception;

import org.ogkm.Lib.entity.OrderItem;

public class OGKMStockShorttageException extends OGKMException {
	private final OrderItem item;
	
	public OGKMStockShorttageException(OrderItem item) {
		super("庫存不足");
		this.item=item;
	}
	public OGKMStockShorttageException(OrderItem item, Throwable cause) {
		super("庫存不足",cause);
		this.item=item;	
	}
	public OrderItem getOrderItem() {
		return item;
	}
	@Override
	public String toString() {
		return super.toString()+
				"\n【item=" + item + "]";
	}

	
	

}
