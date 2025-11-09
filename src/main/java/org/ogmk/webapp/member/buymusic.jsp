<%@page import="com.ogkm.entity.Customer"%>
<%@page import="com.ogkm.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.ogkm.service.ProductService"%>
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
       <%
    Customer member = (Customer)session.getAttribute("member");
    ProductService ps=new ProductService(); 
    List<Product> listp;
    listp = ps.getselectMusicProductsCustomerById(member);
      %>   
      <div id="bought" class="membertab_content">
      <% if(listp==null || listp.isEmpty()) {%>
	        <p>無購買音樂</p>		
	  <%}else{ %>

        <table>
         <caption>已買音樂</caption>
            <thead>
              <tr>
                <th>圖片</th>
                <th>歌名</th>
                <th>下載</th>
              </tr>
            </thead>
            <tbody>
        <% if (listp !=null && listp.size()> 0) {

          for (int i = 0; i < listp.size(); i++) { 
        	  Product p=listp.get(i); %>
              <tr>
                <td><img width="80" src="<%=request.getContextPath()%>/<%=p.getPhotoUrl()%>"></td>
                <td><%=p.getName() %></td>
<!--                 <td><button id="downloadOngakuBtn" ><a>下載</a></button></td> -->
                <td> <button><a href="<%=request.getContextPath()%>/MP3/みっころね×しょうたいむ!!.mp3" download="<%=p.getName() %>.mp3">下載</a></button></td>
<%--                  <td> <button ><a href="<%=p.getMusicUrl() %>" download="<%=p.getName() %>.mp3">下載</a></button></td> --%>
              </tr>
              <%}}%>
            </tbody>
          </table> 
         <%}%>
        </div>
</body>
</html>