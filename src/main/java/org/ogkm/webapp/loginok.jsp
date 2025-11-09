<%@page import="org.ogkm.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="refresh" content="3;url=./">
	<!-- 	之後URL要改回./ -->
	<script>
	var myInterval;
	var index=Number($("#myIndex").attr("data-Index"));
	
	$(document).ready(init);
	function init(){
		$("#myIndex").text($("#myIndex").attr("data-Index"));
		//alert($("#myIndex").text());
		myInterval = setTimeout(intervalHandler, 1000);
	};
		function callHomePage() {
			//同步請求
			location.href = './';
		}
		function moveHandler(){
			clearInterval(myInterval);//reset timer
			myInterval = setTimeout(intervalHandler, 1000);//set timeer
		}
		function intervalHandler(){
			moveHandler();
			//alert(Number($("#myIndex").attr("data-Index")));
		if(Number($("#myIndex").attr("data-Index"))==3){
			$("#myIndex").attr("data-Index","2");
			$("#myIndex").text(Number($("#myIndex").attr("data-Index")));
		
		}else if(Number($("#myIndex").attr("data-Index"))==2){
			$("#myIndex").attr("data-Index","1");
			$("#myIndex").text(Number($("#myIndex").attr("data-Index")));
			
		}else{
		if(Number($("#myIndex").attr("data-Index"))==1){
			$("#myIndex").attr("data-Index","0");
			$("#myIndex").text(Number($("#myIndex").attr("data-Index")));
	
		}}
		}
		
		
	</script>
	<title>登入成功</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
</head>

<body>
	<header>
	<% //System.out.println("3213213");TEST 
	Customer c=(Customer)session.getAttribute("member"); %>
		<h2><%= c!=null?c.getName():"未" %> 會員登入成功</h2>
		<p>
		3秒後回<a href='javascript:callHomePage()'>首頁</a>
		</p>
	</header>
	
		<article>
			<div id="myIndex" data-Index="3"></div>
		</article>
</body>
  <style>
  header{
  display: flex;
  flex-direction:column;
  justify-content: center;
  align-items: center;
  }
  article{
  display: flex;
  justify-content: center;
  font-size: 30em;
font-weight: bold;
  animation: change 1s ;
  animation-iteration-count:3;
  }
  #myIndex{
  
  }
  @keyframes change{
    0%{ background: #dedede;}
    20%{ background: #bab8b8;}
    60%{ background: #8b8c8c;}
    80%{ background: #696969;}
    100%{ background: #ffffff;}
    
}
  </style>
</html>