package org.ogkm.OGKM_Lib.service;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.ogkm.OGKM_Lib.entity.Customer;
import org.ogkm.OGKM_Lib.entity.DeliveryType;
import org.ogkm.OGKM_Lib.entity.Order;
import org.ogkm.OGKM_Lib.entity.OrderItem;
import org.ogkm.OGKM_Lib.entity.OrderStatusLog;
import org.ogkm.OGKM_Lib.entity.PaymentType;
import org.ogkm.OGKM_Lib.entity.Product;
import org.ogkm.OGKM_Lib.entity.TypeColor;
import org.ogkm.OGKM_Lib.exception.OGKMException;
import org.ogkm.OGKM_Lib.exception.OGKMStockShorttageException;

public class OrderDAO {
	private static final String UPDATE_PRODUCTS_MUSIC_SALES=
			"UPDATE products SET Sales=Sales+1"
			+" WHERE id = ? AND category <>'merch'";//ID
	private static final String UPDATE_PRODUCTS_STOCK=
			"UPDATE products SET stock=stock-?"
			+" WHERE stock>=? AND id = ? AND category ='merch'";//數，數，ID
	private static final String UPDATE_PRODUCT_SURROUNDING_STOCK=
			"UPDATE product_merch SET stock=stock-? "
			+" WHERE stock>=?  AND product_id = ? AND typecolorname=?";//數，數，ID，顏色
	private static final String UPDATE_PRODUCT_SURROUNDING_SIZES_STOCK=
	"UPDATE product_merch_sizes SET stock=stock-?"
    +" WHERE stock>=?  AND product_id = ?  AND typecolorname=? AND size=?";//數，數，ID，顏色，尺寸 
	
	
	private static final String INSERT_ORDERS = "INSERT INTO orders"
+ "(id, member_id, created_date, created_time,"
+ "recipient_name, recipient_email, recipient_phone," 
+ "shipping_addres, payment_type, payment_fee,"
+ "delivery_type, delivery_fee,  status)" 
+ " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,0)";
	private static final String INSERT_ORDER_ITEMS = "INSERT INTO order_items" 
+ "(order_id, product_id, "
+ "typecolorname, size, price, quantity)" 
+ " VALUES(?,?,?,?,?,?)";

	void insert(Order order) throws OGKMException {
		if (order == null)
			throw new IllegalArgumentException("新增訂單時order物件不得為NULL");

		try (Connection connection = RDBConnection.getConnection(); // 1.2取得連線
				PreparedStatement update_Sales=connection.prepareStatement(UPDATE_PRODUCTS_MUSIC_SALES);
				PreparedStatement updateproduct_Stock=connection.prepareStatement(UPDATE_PRODUCTS_STOCK);
				PreparedStatement updatecolor_Stock=connection.prepareStatement(UPDATE_PRODUCT_SURROUNDING_STOCK);
				PreparedStatement updatecolorsize_Stock=connection.prepareStatement(UPDATE_PRODUCT_SURROUNDING_SIZES_STOCK);
				PreparedStatement pstmt1 = connection.prepareStatement(INSERT_ORDERS, Statement.RETURN_GENERATED_KEYS); // 3準備pstmt
				PreparedStatement pstmt2 = connection.prepareStatement(INSERT_ORDER_ITEMS);
			){
			
			connection.setAutoCommit(false);//類似begin transoction
			try {
				//修改庫存
				for(OrderItem orderItem:order.getOrderItemSet()) {
					Product p = orderItem.getProduct();
					TypeColor typeColor = orderItem.getTypecolor();
					String size = orderItem.getSize();
					int qty = orderItem.getQuantity();
					
					PreparedStatement pstmtupdate;
					if((typeColor!=null && size!=null && !size.isEmpty()) ||
							(typeColor==null && size!=null && !size.isEmpty())) {
						pstmtupdate = updatecolorsize_Stock;	
						pstmtupdate.setInt(1, qty);
						pstmtupdate.setInt(2, qty);
						pstmtupdate.setInt(3, p.getId());
						pstmtupdate.setString(4, typeColor!=null?typeColor.getTypecolorname():"");
						pstmtupdate.setString(5, size);									
					}else if(typeColor!=null && (size==null && size.isEmpty())) {
						pstmtupdate = updatecolor_Stock;
						pstmtupdate.setInt(1, qty);
						pstmtupdate.setInt(2, qty);
						pstmtupdate.setInt(3, p.getId());
						pstmtupdate.setString(4, typeColor.getTypecolorname());
					}else {
						if(p.getCategory().equals("merch")) {
						pstmtupdate = updateproduct_Stock;
						pstmtupdate.setInt(1, qty);
						pstmtupdate.setInt(2, qty);
						pstmtupdate.setInt(3, p.getId());
					    }else {
						pstmtupdate = update_Sales;
						pstmtupdate.setInt(1, p.getId());
					    }  
					}
				
					int row=pstmtupdate.executeUpdate();
					if(row==0) throw new OGKMStockShorttageException(orderItem);						
				}	
			//新增訂單
			// 3.1傳入pstmt1 ? 值
			pstmt1.setInt(1, order.getId());
			pstmt1.setString(2, order.getMember().getId());
			pstmt1.setString(3, order.getCreatedDate().toString());
			pstmt1.setString(4, order.getCreatedTime().toString());
			pstmt1.setString(5, order.getRecipientName());
			pstmt1.setString(6, order.getRecipientEmail());
			pstmt1.setString(7, order.getRecipientPhone());
			pstmt1.setString(8, order.getShippingAddres());
			pstmt1.setString(9, order.getPaymentType().name());
			pstmt1.setDouble(10, order.getPaymentFee());
			pstmt1.setString(11, order.getDeliveryType().name());
			pstmt1.setDouble(12, order.getDeliveryFee());

			// 4.執行pstmt1指令
			int rows= pstmt1.executeUpdate();
			// 讀KEY
			try (
					ResultSet rs = pstmt1.getGeneratedKeys();
					){
				while (rs.next()) {
					order.setId(rs.getInt(1));	
				}

			}
			//新增訂單明細
			for(OrderItem orderItem :order.getOrderItemSet() ) {
				Product p =orderItem.getProduct();
				TypeColor typecolor =orderItem.getTypecolor();
				String size =orderItem.getSize();
				// 3.1傳入pstmt2 ? 值
				pstmt2.setInt(1, order.getId());
				pstmt2.setInt(2, p.getId());
				pstmt2.setString(3, typecolor!=null?typecolor.getTypecolorname():"");
				pstmt2.setString(4, size!=null?size:"");
				pstmt2.setDouble(5, orderItem.getPrice());
				pstmt2.setInt(6, orderItem.getQuantity());
				
				// 4.執行pstmt2指令
				pstmt2.executeUpdate();
			}
			
			
			connection.commit();//commit 
			}catch(Exception e) {
				
				connection.rollback();//rollback
				throw e;
			}finally {
				connection.setAutoCommit(true);
			}
		} catch (SQLException e) {
			throw new OGKMException("新增訂單失敗", e);
		}
	}
	
	private static final  String SelectOrdersByCustomer=
			"SELECT id, member_id,created_date, created_time,"
			+ "payment_type,payment_fee,"
			+ "delivery_type,delivery_fee,status,"
			+"sum(price*quantity) as total_amount"
			+" FROM orders left joIN order_items on id=order_id"
			+" Where member_id=? "
			+" GROUP BY orders.id";
	List<Order>selectOrdersByCustomer(String customerId) throws OGKMException{
			if(customerId==null||customerId.length()==0) 
				throw new IllegalArgumentException("查詢歷史訂單時memberId必須有值");
				List<Order> list = new ArrayList<>();
				
				try (Connection connection = RDBConnection.getConnection(); //1,2 取得連線
						 PreparedStatement pstmt = connection.prepareStatement(SelectOrdersByCustomer+" order by orders.id desc"); //3.準備指令
							) {
						//3.1傳入?的值
						pstmt.setString(1, customerId);
						
						try(ResultSet rs = pstmt.executeQuery();			//4.執行指令
							){
							//5.處理rs
							while(rs.next()) {
								Order order = new Order();
								order.setId(rs.getInt("id"));
								
								Customer c = new Customer();
								c.setId(rs.getString("member_id"));
								order.setMember(c);
								
								order.setCreatedDate(LocalDate.parse(rs.getString("created_date")));
								order.setCreatedTime(LocalTime.parse(rs.getString("created_time")));
								
								String pType = rs.getString("payment_type");
								try {
									PaymentType paymentType = PaymentType.valueOf(pType);
									order.setPaymentType(paymentType);					
								}catch(Exception e) {
									System.err.println ("付款方式不正確: " + pType);
								}
								
								order.setPaymentFee(rs.getDouble("payment_fee"));
								
								String dType = rs.getString("delivery_type");
								try {
									DeliveryType deliveryType = DeliveryType.valueOf(dType);
									order.setDeliveryType(deliveryType);					
								}catch(Exception e) {
									System.out.println ("貨運方式不正確: " + dType);
								}
								
								order.setDeliveryFee(rs.getDouble("delivery_fee"));
							
								order.setStatus(rs.getInt("status"));
								order.setTotalAmount(rs.getDouble("total_amount"));
								
								list.add(order);
							}
						}		
						
					} catch (SQLException e) {
						throw new OGKMException("查詢歷史訂單失敗",e);
					}
				
					return list;
			   }	
	private static final  String SelectHistoryByCustomer=
			"SELECT orders.id, member_id, created_date, created_time,"
			+ "recipient_name, recipient_email, recipient_phone, shipping_addres,"
			+ "payment_type, payment_fee, payment_note,"
			+ "delivery_type,delivery_fee, delivery_note, status,"
			+ "order_id,order_items.product_id,"
			+ "category,products.photoUrl,products.name AS product_name,"
			+ "order_items.typecolorname,product_merch.typecolorname AS p_typecolorname,"
			+ "product_merch.colorphotourl,size,price,quantity"
			+" FROM orders JOIN order_items ON orders.id=order_items.order_id"
			+" JOIN products ON order_items.product_id=products.id"
			+" LEFT JOIN product_merch ON order_items.product_id=product_merch.product_id"
			+" AND order_items.typecolorname=product_merch.typecolorname"
			+" Where member_id=? AND orders.id=?";
	Order selectHistoryByCustomer(String customerId, String orderId) throws OGKMException {
		Order order = null;
		try (Connection connection = RDBConnection.getConnection(); //1,2 取得連線
				 PreparedStatement pstmt = connection.prepareStatement(SelectHistoryByCustomer); //3.準備指令
			) {
			//3.1傳入?的值
			pstmt.setString(1, customerId);
			pstmt.setString(2, orderId);
						
						try(ResultSet rs = pstmt.executeQuery();			//4.執行指令
							){
							//5.處理rs
							while(rs.next()) {
								if(order==null) {
								order = new Order();
								order.setId(rs.getInt("id"));
								
								Customer c = new Customer();
								c.setId(rs.getString("member_id"));
								order.setMember(c);
								
								order.setCreatedDate(LocalDate.parse(rs.getString("created_date")));
								order.setCreatedTime(LocalTime.parse(rs.getString("created_time")));
								
								String pType = rs.getString("payment_type");
								try {
									PaymentType paymentType = PaymentType.valueOf(pType);
									order.setPaymentType(paymentType);					
								}catch(Exception e) {
									System.err.println ("付款方式不正確: " + pType);
								}
								order.setPaymentFee(rs.getDouble("payment_fee"));
								order.setPaymentNote(rs.getString("payment_note"));
								
								String dType = rs.getString("delivery_type");
								try {
									DeliveryType deliveryType = DeliveryType.valueOf(dType);
									order.setDeliveryType(deliveryType);					
								}catch(Exception e) {
									System.out.println ("貨運方式不正確: " + dType);
								}
								order.setDeliveryFee(rs.getDouble("delivery_fee"));
								order.setDeliveryNote(rs.getString("delivery_note"));
								order.setStatus(rs.getInt("status"));
								
								order.setRecipientName(rs.getString("recipient_name"));
								order.setRecipientEmail(rs.getString("recipient_email"));
								order.setRecipientPhone(rs.getString("recipient_phone"));
								order.setShippingAddres(rs.getString("shipping_addres"));
								}
								OrderItem orderItem = new OrderItem();
								Product p = new Product();
								p.setId(rs.getInt("product_id"));
								p.setName(rs.getString("product_name"));
								p.setPhotoUrl(rs.getString("photoUrl"));
								orderItem.setProduct(p);
								
								String typecolorName = rs.getString("p_typecolorname");
								TypeColor typecolor = null;
								if(typecolorName!=null) {
									typecolor = new TypeColor();
									typecolor.setTypecolorname(rs.getString("typecolorname"));
									typecolor.setPhotourl(rs.getString("colorphotourl"));
									orderItem.setTypecolor(typecolor);
								}	
								orderItem.setSize(rs.getString("size"));
								orderItem.setPrice(rs.getDouble("price"));
								orderItem.setQuantity(rs.getInt("quantity"));	
								
								order.add(orderItem);
							}
						}		
						
					} catch (SQLException e) {
						throw new OGKMException("查詢歷史訂單失敗",e);
					}
				
		            return order;
			   }
//修改訂單狀態
	private static final String UPDATE_ORDER_STATUS_TO_TRANSFERED = 
			"UPDATE orders SET status=1, " //狀態設定為已通知付款
            + "payment_note=? WHERE id=? AND member_id=? "
            + "AND status=0 AND payment_type='" + PaymentType.ATM.name() + "'";
    void updateOrderStatusToTransfered(String customerId, int id,String paymentNote) throws OGKMException {
        try (Connection connection = RDBConnection.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER_STATUS_TO_TRANSFERED);) {

            //3.1 傳入?的值
            pstmt.setString(1, paymentNote);            
            pstmt.setInt(2, id);
            pstmt.setString(3, customerId);
            //4.執行指令
            pstmt.executeUpdate();

        } catch (SQLException ex) {
            throw new OGKMException("[修改訂單狀態為已轉帳]失敗", ex);
        }
    }
    
    private static final String SELECT_ORDER_STATUS_LOG = 
    		"SELECT order_id, old_status, new_status, old_payment_note,"
    		+"new_payment_note, update_time"
    		+" FROM order_status_log WHERE order_id=?";
    List<OrderStatusLog> selectOrderStatusLog(String orderId)throws OGKMException{
    	List<OrderStatusLog> list = new ArrayList<>();
		try(Connection connection = RDBConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_STATUS_LOG);
				){
			//3.1 傳入?的值
			pstmt.setString(1, orderId);
			
			//4. 執行指令
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					OrderStatusLog log = new OrderStatusLog();
					log.setId(rs.getInt("order_id"));
					log.setOldStatus(rs.getInt("old_status"));
					log.setStatus(rs.getInt("new_status"));
					log.setLogTime(rs.getString("update_time"));
					list.add(log);
				}				
			}
			return list;
		}catch(SQLException ex) {
			throw new OGKMException("查詢訂單狀態Log失敗", ex);
		}    	
    }
    
    private static final String UPDATE_STATUS_TO_ENTERED = 
    		"UPDATE orders SET status=2," //狀態設定為已付款
            +"payment_note=? WHERE member_id=? AND id=?"
            +" AND status=0" + " AND payment_type='" 
            + PaymentType.CREDIT_CARDPAYMENT.name() + "'";

    public void updateOrderStatusToPAID(String memberId, int orderId, String paymentNote) throws OGKMException {
        try (Connection connection = RDBConnection.getConnection(); //2. 建立連線
                PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_ENTERED) //3. 準備指令
                ) {

            //3.1 傳入?的值
            pstmt.setString(1, paymentNote);
            pstmt.setString(2, memberId);
            pstmt.setInt(3, orderId);
            
            //4. 執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {

            System.out.println("修改信用卡付款入帳狀態失敗-" + ex);

            throw new OGKMException("修改信用卡付款入帳狀態失敗!", ex);

        }

    }
}