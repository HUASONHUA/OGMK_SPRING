<%@page import="org.ogkm.OGKM_Lib.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="refresh" content="5;url=./">
	<title>註冊成功</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">

	<script>
		function callHomePage() {
			//同步請求
			location.href = './';
		}	
	</script>

</head>

<body>
	<header>
		<h2>註冊成功</h2>
	</header>
	<% Customer c=(Customer)request.getAttribute("member"); %>
		<article>
			<p>
				<%= c!=null?c.getName():"<b>未</b>" %>註冊成功! 5秒後回<a href='javascript:callHomePage()'>首頁</a>
			</p>
		</article>
</body>

</html>