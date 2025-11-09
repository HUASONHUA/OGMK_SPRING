package org.ogkm.OGKM_Lib.service;

import java.time.LocalDateTime;
import java.util.List;

import org.ogkm.OGKM_Lib.entity.Customer;
import org.ogkm.OGKM_Lib.entity.Order;
import org.ogkm.OGKM_Lib.entity.OrderStatusLog;
import org.ogkm.OGKM_Lib.exception.OGKMException;

public class OrderService {
	private OrderDAO dao=new OrderDAO();
public void createOrder(Order order)throws OGKMException{
	dao.insert(order);
}
public List<Order> getOrdersHistory(Customer member)
		throws OGKMException{
	if(member==null)throw new IllegalArgumentException();
	return dao.selectOrdersByCustomer(member.getId());
}
public Order getOrderById(Customer member, String orderId) throws OGKMException{
	return dao.selectHistoryByCustomer(member.getId(), orderId);
}

public void updateOrderStatusToTransfered(Customer member, String id, 
        String bank, String last5Code, String amount, String date, String time) throws OGKMException {        
    if(member==null || member.getId().length()==0) throw new IllegalArgumentException("通知轉帳必須傳入member id");
    if(id==null || id.length()==0) throw new IllegalArgumentException("通知轉帳必須傳入order id");
    String paymentNote = "銀行:" + bank + ","
            + "帳號後5碼:" + last5Code + ","
            + "金額:" + amount + ","
            + date + " " + time+"完成轉帳";

    dao.updateOrderStatusToTransfered(member.getId(), Integer.parseInt(id), paymentNote);
}	

public List<OrderStatusLog> getOrderStatusLog(String orderId)throws OGKMException{
	return dao.selectOrderStatusLog(orderId);
}

public void updateOrderStatusToPAID(String memberId,String orderId, String cardF6, String cardL4,
        String auth, String paymentDate, String amount) throws OGKMException {
    StringBuilder paymentNote = new StringBuilder("信用卡號:");
   paymentNote.append(cardF6==null?"4311-95":cardF6).append("**-****").append(cardL4==null?2222:cardL4);
   paymentNote.append(",授權碼:").append(auth==null?"777777":auth);
   paymentNote.append(",交易時間:").append(paymentDate==null?LocalDateTime.now():paymentDate);
//    paymentNote.append(",刷卡金額:").append(amount);
   System.out.println("orderId = " + orderId);
   System.out.println("memberId = " + memberId);
   System.out.println("paymentNote = " + paymentNote);
   dao.updateOrderStatusToPAID(memberId, Integer.parseInt(orderId), paymentNote.toString());

}

}
