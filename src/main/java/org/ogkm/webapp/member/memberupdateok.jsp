<%@page import="com.ogkm.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="refresh" content="5;url=<%=request.getContextPath()%>">
<title>註冊成功</title>
 <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">

	<script>
		function callHomePage(){
			//同步請求
			location.href='<%=request.getContextPath()%>';
		}	
	</script>
</head>
<body>
	<header>	
		<h2>修改成功</h2>
	</header>
	<%	Customer c = (Customer)session.getAttribute("member");	%>	
	<article>
		<p><%= c!=null?c.getName():"<b>未</b>" %>修改成功! 5秒後回<a href='javascript:callHomePage()'>首頁</a></p>		
	</article>
</body>
</html>