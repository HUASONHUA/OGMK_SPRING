<%@page import="org.ogkm.OGKM_Lib.service.ProductService"%>

<%@page import="org.ogkm.OGKM_Lib.entity.Size"%>
<%@page import="java.util.Set"%>
<%@ page pageEncoding="UTF-8"%>
<%
	String productId = request.getParameter("productId");
	String typecolorname = request.getParameter("typecolorname");
	Set<Size> sizeSet = null; 
	if(productId!=null && typecolorname!=null){
		ProductService ps = new ProductService();
		sizeSet = ps.getProductSizeSet(productId, typecolorname);
	}
	boolean noData = (sizeSet==null || sizeSet.isEmpty());
%>
<option <%=noData?"disabled":"" %> value=''>請選擇...</option>
<% if(!noData){
		for(Size size:sizeSet){
%>
<option value='<%=size.getName() %>' data-stock='<%=size.getStock() %>' 
	 data-price='<%=size.getUnitprice()%>'><%=size.getName() %></option>
<%		}
	} %>
