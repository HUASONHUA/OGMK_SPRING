<%@page import="java.util.List"%>
<%@page import="com.ogkm.entity.OrderStatusLog"%>
<%@page import="com.ogkm.entity.OrderItem"%>
<%@page import="com.ogkm.service.OrderService"%>
<%@page import="com.ogkm.entity.Order"%>
<%@page import="com.ogkm.entity.Customer"%>
<%@page import="com.ogkm.entity.PaymentType"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.ogkm.entity.Outlet"%>
<%@page import="com.ogkm.entity.TypeColor"%>
<%@page import="com.ogkm.entity.Product"%>
<%@page import="com.ogkm.entity.Cartltem"%>
<%@page import="com.ogkm.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<%! private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");%>

<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/fancybox3/jquery.fancybox.css">
  <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src='<%=request.getContextPath() %>/fancybox3/jquery.fancybox.js'></script>

  <title>翁卡克MUISC</title>
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
</head>

<body>
  <jsp:include page="/SubViews/NAV.jsp"/>
<%
		Customer member = (Customer)session.getAttribute("member");
		String orderId = request.getParameter("orderId");
		Order order = null;
		OrderService os = new OrderService();
		List<OrderStatusLog> logList = null;
		
		if(member!=null && orderId!=null){
			order = os.getOrderById(member, orderId);
		}	
	%>
  <div class="cartbag">
    <form action="" method="POST">
      <div class="cartcontent">
        <%if(order==null){%>
          <div class="cartnull">
            <p>查無此訂單(<%=orderId %>)</p>
          </div>
        <%}else{ %>
        <div class='statusbag'>
        <div class='statusCSS' title='<%=order.getCreatedDate() %> 
        <%=order.getCreatedTime() %>'>下單</div>	
        <% logList = os.getOrderStatusLog(orderId);
			if(logList!=null && logList.size()>0){
			for(OrderStatusLog log:logList){
			%>		
			<div class='statusCSS' title='<%= log.getLogTime() %>'>
			<%=order.getStatusString(log.getStatus()) %></div>
			<% }} %>
		</div>
          <table>
            <caption>訂單明細</caption>
            <thead>
              <tr>
                <th>圖片</th>
                <th>名稱</th>
                <th>種類<br>顏色</th>
                <th>尺寸</th>
                <th>價格</th>
                <th>數量</th>
              </tr>
            </thead>
            <tbody>
              <% for(OrderItem orderItem:order.getOrderItemSet()){ 
						Product p = orderItem.getProduct();
						TypeColor typecolor = orderItem.getTypecolor();					
					%>
			  <tr>
                <td><img class="cartphoto"
                    src="<%=request.getContextPath()%>/<%=typecolor!=null && typecolor.getPhotourl()!=null?typecolor.getPhotourl():p.getPhotoUrl()%>">
                </td>
                <td class="pnamewidth"><%=p.getName() %></td>
                <td class="ptypecolorwidth"><%=typecolor!=null?typecolor.getTypecolorname():"--" %></td>
                <td><%=orderItem.getSize() %></td>
                <td><%=orderItem.getQuantity() %></td>
                <td><%=orderItem.getPrice()*orderItem.getQuantity()%> </td>
              </tr>
              <%} %>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="2">
                  <div class="PDmethodbag">
                    <label>訂單編號:<%= order.getId()%></label>
                    <label>處理狀態: <%= order.getStatusString()%></label>
                    <label>日期:<%= order.getCreatedDate()%> </label>
                    <label>時間: <%= order.getCreatedTime()%></label>
                    <label>商品價格:<%=order.getTotalAmount()%>元</label>
                    <label>付款方式 <%= order.getPaymentType().getPaymendescription()%> 
						<%= order.getPaymentFee()>0?order.getPaymentFee()+"元":"" %></label>
					<% if(order.getPaymentType()==PaymentType.ATM && order.getStatus()==0){%>
						<a href='atm_transfered.jsp?orderId=<%= order.getId() %>'>(通知已轉帳)</a>
						<% } %>	
                    <label>送貨方式 <%= order.getDeliveryType().getDeliverydescription()%>
						<%= order.getDeliveryFee()>0?order.getDeliveryFee()+"元":"" %></label>
                  </div>
                  
                </td>
                
                <td colspan="5">
                  <fieldset class="addressee">
                    <legend>收件人</legend>
                    <div class="addresseebag">
                      <label>姓名:<%= order.getRecipientName()%></label>
                      <label>電話:<%= order.getRecipientPhone()%></label>
                      <label>email:<%= order.getRecipientEmail()%></label>
                      <label>地址:<%= order.getShippingAddres()%></label>
                    </div>
                  </fieldset>
                </td>
              </tr>
              <tr>
                <td colspan="2">件數:<%=order.size() %>項<%=order.getTotalQuantity() %>件</td>
                <td colspan="6">總價格:<%=order.getTotalAmountWithFee()%>元</td>
              </tr>
            </tfoot>
          </table>
        <%}%>
      </div>
    </form>
  </div>

  <style>
    /*查無商品*/
    .cartnull {
      display: flex;
      justify-content: center;
    }

    /*查無商品 END*/
    .cartbag {
      padding: 3.5em 0;
    }
    .statusbag{
    display: flex;
    justify-content: center;
    margin: 0.5em 0;
    }
    .statusCSS{
    text-align:center;
    width: 3.5em;
    color:#FFF;
    height: auto;
    border-radius: 0.5em;
    background: #616361;
    margin:0em 0.2em 0em 0;
    }

    .cartcontent {
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 0em 0.5em;
      margin: 0 auto;
      min-height: 72vh;
    }

    .cartcontent table {
      border: 1px solid gray;
      border:none;
      border-top: none;
      border-collapse: collapse;
    }

    .cartcontent caption {
      border: 1px solid gray;
      border-bottom: none;
    }

    .cartcontent caption,
    .cartcontent thead {
      background-color: orange;
    }

    .cartcontent th,
    .cartcontent td {
      border: 1px solid gray;
      padding: 0.5em 0.2em;
    }

    .cartphoto {
      width: 5em;
    }

    .ptypecolorwidth,
    .pnamewidth {
      word-wrap: break-word;
    }

    .pUnitPricewidth {
      width: auto;
    }

    .cartcontent tbody,
    .cartcontent tfoot {
      text-align: center;
    }

    .cartcontent tbody tr:nth-child(2n+2) {
      background-color: #ebebeb;
    }

    /*商品表格 END */

    /*付款方式*/
    .PDmethodbag {
      display: flex;
      flex-direction: column;
      justify-content: space-evenly;
      align-items:flex-start;
      width: 100%;
    }
     .cartcontent tfoot  {
    box-shadow: rgba(0, 0, 0, 0.4) 0px 5px,
     rgba(0, 0, 0, 0.3) 0px 10px,
     rgba(0, 0, 0, 0.2) 0px 15px,
     rgba(0, 0, 0, 0.1) 0px 20px,
     rgba(0, 0, 0, 0.05) 0px 25px;
     
     }

    .cartcontent tfoot tr:nth-child(1) td{
    padding-top: 1em;
    border: 0;
    }
    .cartcontent tfoot tr:nth-child(2) td{
      border: 0;
    }
    .cartcontent tfoot tr:nth-child(2){
    text-align: left;
    }

    /*付款方式 END*/

    /*收件人*/
    .addressee {
      text-align:left;
      display: flex;
      flex-direction: column;
      justify-content: space-around;
      align-items: flex-start;
      border: 0;
      padding:0.5em 0 0 0;
    }

    /*收件人 END*/
    .addresseebag {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      text-align: left;
    }

    /*收件人 END*/

    /*小於500PX*/
    @media (max-width: 500px) {
    .statusCSS{
    width: 5em;
    height: auto;
    font-size: 0.5em;
    }
      .cartcontent th,
      .cartcontent td {
        font-size: 0.5em;
        padding: 0.5em 0.2em;
      }

      .cartphoto {
        width: 3em;
      }

      .ptypecolorwidth,
      .pnamewidth {
        max-width: 3.5em;
      }

      .pUnitPricewidth {
        max-width: 2em;
      }
    }

    /*超過800PX*/
    @media (min-width: 800px) {
    
      .cartcontent {
        display: flex;
        align-items: center;
      }

      .cartcontent th,
      .cartcontent td {
        padding: 0.5em 0.5em;
        font-size: 1.5em;
      }

      .cartphoto {
        width: 8em;
      }
    }

    /*超過800PX END*/
  </style>
</body>

</html>