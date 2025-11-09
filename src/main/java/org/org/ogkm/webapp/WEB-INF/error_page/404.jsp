<%@ page  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>404</title>
</head>
<body>

<jsp:include page="/SubViews/NAV.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	<div class="e404bag">
	<h1>找不到網頁<%=request.getAttribute("jakarta.servlet.error.request_uri") %></h1>
	<img class="e404" src="<%=request.getContextPath() %>/images/404.jpg">
	</div>
	<style>
	h1{
	margin: 0;
	padding-top:2em;
	}
	.e404bag{
	display: flex;
	flex-direction: column;
	align-items: center;
	}
	.e404{
	width: 90vw;
	height: 80vh;
	}
	</style>
</body>
</html>