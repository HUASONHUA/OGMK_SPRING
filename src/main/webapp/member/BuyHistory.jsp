<%@page import="org.ogkm.OGKM_Lib.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page import="org.ogkm.OGKM_Lib.service.OrderService"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Order"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<title>翁卡克MUISC</title>
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
</head>
<body>
 <% Customer member = (Customer)session.getAttribute("member");
    OrderService os = new OrderService();			
			List<Order> list = null;
			if(member!=null){
				list = os.getOrdersHistory(member);
		}%>
        <div id="BuyHistory" class="membertab_content">
        <% if(list==null || list.isEmpty()) {%>
			<p>查無歷史訂單</p>
			<%}else{ %>
          <table>
            <caption>訂單明細</caption>
            <thead>
              <tr>
                <th>編號</th>
                <th>訂購<br>日期</th>
                <th>訂單<br>狀態</th>
                <th>價錢</th>
                <th>檢視</th>
              </tr>
            </thead>
            <tbody>
            <%for(Order order: list) {%>
             <tr>
              <td><%=order.getId() %></td>
              <td><%=order.getCreatedDate() %><br><%=order.getCreatedTime() %></td>
              <td><%=order.getStatus() %></td>
              <td><%=order.getTotalAmountWithFee() %></td>
              <td><a href='order.jsp?orderId=<%= order.getId()%>'>明細</a></td>
             </tr>
              <%} %>
            </tbody>
            <%} %>
          </table>
        </div>
</body>
</html>