<%@page import="java.util.Date"%>
<%@page import="java.util.Random"%>
<%@ page pageEncoding="UTF-8" isErrorPage="true" buffer="2kb" autoFlush="false"%>
<%
	request.setCharacterEncoding("UTF-8");	
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	label{font-weight: bold;color:gray}
</style>
<title>隱含變數</title>
</head>
<body>
	<h2>隱含變數(implicit variables)
		<a href='#response'>response</a> | <a href='#out'>out</a> |
		<a href='#session'>session</a>
	</h2>
	<h3>request***</h3>
	<%
		String method=request.getMethod();
	%>
	<p>請求方式: <%= method%></p>
	<p><label>getRequestURL():</label> <%= request.getRequestURL() %></p>
	<p><label>getRequestURI():</label> <%= request.getRequestURI() %></p>
	<p><label>getProtocol():</label> <%= request.getProtocol() %></p>

	<p><label>(Server) getLocalName():</label> <%= request.getLocalName() %></p>
	<p><label>(Server) getLocalAddr():</label> <%= request.getLocalAddr()%></p>
	<p><label>(Server) getLocalPort():</label> <%= request.getLocalPort()%></p>	
	<p><label>getContextPath():</label> <%= request.getContextPath() %></p>
	<% 
		out.flush(); //for test
		Thread.sleep(new Random().nextInt(1800)+200); //for test	   
	%>
	<p><label>getQueryString():</label> <%= request.getQueryString() %></p>
	<p><label>getHeader("user-agent"):</label> <%= request.getHeader("user-agent") %></p>
	<p><label>getHeader("accept"):</label> <%= request.getHeader("accept") %></p>
	<p><label>getHeader("accept-language"):</label> <%= request.getHeader("accept-language") %></p>
	
	<p><label>(Client) getRemoteHost():</label> <%= request.getRemoteHost() %></p>
	<p><label>(Client) getRemoteAddr():</label> <%= request.getRemoteAddr() %></p>
	<p><label>(Client) getRemotePort():</label> <%= request.getRemotePort()%></p>
	<form method='POST' id="testForm" action="#testForm">
		<fieldset>
			<legend>POST Form Data</legend>
			<input name='id' placeholder="請輸入id" required>
			<input type="submit">
		</fieldset>
	</form>
	
	<p><label>getParameter("id"):</label> <%= request.getParameter("id") %></p>
	<hr>
	
	<h3 id='response'>response</h3>	
	<p><label>getContentType():</label><%= response.getContentType()%></p>
	<p><label>getBufferSize():</label><%= response.getBufferSize()%></p>
	<hr>
	<% out.flush(); //for test%>
	<h3 id='out'>out*</h3>	
	<p><label>getBufferSize():</label><% out.print(out.getBufferSize());  %></p>
	<hr>
	<h3 id='session'>session**</h3>	
	<p><label>session Id:</label><%= session.getId() %></p>	
	<p><label>timeout:</label><%= session.getMaxInactiveInterval() %> 秒</p>
	<p><label>created time:</label><%= new Date(session.getCreationTime()) %></p>
	<p><label>Last Accessed Time:</label><%= new Date(session.getLastAccessedTime()) %></p>
	<hr>
	<h3 id='application'>application*</h3>	
	<p><label>ContextPath: </label><%= application.getContextPath() %></p>	
	<p><label>real Path: </label><%= application.getRealPath("/") %></p>
	<hr>
	<h3 id='config'>config</h3>	
	<p><label>this.Servlet Name: </label><%= this.getServletName() %></p>	
	<p><label>config.Servlet Name: </label><%= config.getServletName() %></p>
	<hr>
	<h3 id='pageContext'>pageContext</h3>	
	<p><label>ContextPath: </label><%= ((HttpServletRequest)pageContext.getRequest()).getContextPath() %></p>	
	<p><label>ContextPath: </label><%= request.getContextPath() %></p>
	<p><label>config.Servlet Name: </label><%= pageContext.getServletConfig().getServletName() %></p>
	<p><label>config.Servlet Name: </label><%= config.getServletName() %></p>
	<hr>	
	<h3 id='page'>page</h3>
	<p>this.getServletName: <%= ((HttpServlet)page).getServletName()%></p>
	<%! int i=200; %>
	<% int i=20; %>
	<p>this.i: <%= this.i%></p>
	<p>i: <%= i%></p>
	<p>this==page: <%= this==page %></p>
	<hr>
	<h3 id='exception'>exception</h3>
	<p>exception: <%= exception%></p>
</body>
</html>