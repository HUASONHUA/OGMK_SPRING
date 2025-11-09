<%@page import="java.time.LocalDate"%>
<%@page import="org.ogkm.entity.Order"%>
<%@page import="org.ogkm.service.OrderService"%>
<%@page import="org.ogkm.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Insert title here</title>
</head>
<body>
<%		
		String orderId=request.getParameter("orderId");
        Customer member = (Customer)session.getAttribute("member");
    	OrderService oService = new OrderService();	
		Order order = null;
		if(member!=null && orderId!=null){
			order = oService.getOrderById(member, orderId);
		}
	%>
	<article>
	<%if(order!=null){ %>
	<form class='atmForm' action="atm_transfered.do" method="POST">
	${requestScope.errors}
	<div>
	 <label>訂單編號:</label>
     <input readonly name="orderId" value="<%= order.getId() %>">
    </div>
    <div>
     <label>轉帳銀行:</label>
     <input required name="bank" placeholder="請輸入轉帳銀行名稱" value="${param.bank}">
	</div>
	<div>
	<label>帳號後5碼:</label>
     <input required name="last5Code" placeholder="請輸入轉帳帳號後5碼"
     value="${param.last5Code}">
    </div>
    <div>
	 <label>轉帳金額:</label>
     <input required type="number" min="1" name="amount" 
     value="<%= request.getParameter("amount")==null?order.getTotalAmountWithFee():request.getParameter("amount") %>" >
	</div>
	<div>
	 <label>轉帳日期:</label>
     <input type="date" required name="date" min="<%= order.getCreatedDate() %>" max="<%= LocalDate.now() %>" value="${param.date}">
     <label>時間:</label>約
     <select required name="time">
      <option value="">請選擇...</option>
      <% for(int i=0;i<24;i++) {%>
      <option value="<%=i%>:00"><%=i%>:00</option>
	  <option value="<%=i%>:30"><%=i%>:30</option>
      <% } %>
     </select>
	</div>
	<input type="reset" value="還原"/>
    <input type="submit" value="確定"/>
   </form> 
	<%}else{%>
     <p>查無此訂單</p>            
    <%}%>
	</article>
</body>
</html>