<%@page import="org.ogkm.OGKM_Lib.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page import="org.ogkm.OGKM_Lib.service.ProductService"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
</head>

<body>
<jsp:include page="/SubViews/NAV.jsp"/>
  <%
    ProductService ps=new ProductService();
    List<Product> list;
    Customer member = (Customer)session.getAttribute("member");
    list = ps.getselectMusicProductsCustomerById(member);
    
    if (member != null) {
  %>
    <% if(list==null || list.isEmpty()) {%>
    <p id="pbag">無購買音樂</p>
    <% } else { %>
    <div id="imageslider" class="transparency">
		  <ul>
			  <li aspectindex="0"><img src="" /></li>
			  <li aspectindex="1"><img src="" /></li>
			  <li aspectindex="2"><img src="" /></li>
			  <li aspectindex="3"><img src="" /></li>
		  </ul>
	  </div>
	  <div>
	    <input id="seekAudioTime" type="range" min="0" value=""
	      onchange="seekAudioTime()" ontouchmove="seekAudioTime()">
	  </div>
	  <div id="playAudioTime"></div>

	  <div class="audiobag">
		  <div class="nextprevWidth">
		  	<div id="prevcss">
			    <button id="prevBtn">
            <i class="fas fa-backward"></i>
			    </button>
        </div>
			  <div id="transparency">
			    <button id="playBtn">
			      <img src="<%=request.getContextPath()%>/images/audio/play1.png">
			    </button>
			  </div>
			  <div id="nextcss"><button id="nextBtn">
			    <i class="fas fa-forward"></i>
			  </button></div>
		  </div>

		  <audio id="audiovisual" src="" type="audio/mpeg"></audio>

		  <div>
			  <a id="volumeBtn">
			    <img src="<%=request.getContextPath()%>/images/audio/volume.png">
			  </a>
			  <input id="volumerange" ontouchmove="volumeUpDownHandler()"
          type="range" value="25" min="0" max="100">
			  <a id="loopBtn" data-control="auto">
			    <img src="<%=request.getContextPath()%>/images/audio/loop.png">
			  </a>
		  </div>
	  </div>
	  <div id="songBanner">
		  <div class="leftside">
      <!-- 	<div id="songlist">歌曲列表</div> -->
      <% if (list !=null && list.size()> 0) {
           for (int i = 0; i < list.size(); i++) {
           Product p=list.get(i); %>
        <div class="songbag">
	        <div class="songcolumnbag">
		        <span><%=i+1%></span>
		        <a class="changemuisc" songcolumnindex="<%=i+1%>"
		            data-src='<%=request.getContextPath()%>/<%=p.getMusicUrl()%>'
		            data-photo="<%=request.getContextPath()%>/<%=p.getPhotoUrl() %>"
		            onclick="Achangemuisc(this)">
		          <img src="<%=request.getContextPath()%>/images/audio/play1.png"
		            onclick="Achangeing(this)">
		        </a>
		        <img id="songcolumnimg"
		          src="<%=request.getContextPath()%>/<%=p.getPhotoUrl()%>">
		        <div class="playAudioTime"><%=p.getName() %></div>
	        </div>
        </div>
	    <% } } %>
	    </div>
      <div class="rightside">歌曲列表</div>
	  </div>
    <% } %>
	<% } else { %>
    <h3>請先登入!</h3>
	<% } %>

	<style>
	#pbag{
	display: flex;
	justify-content: center;
	margin: 0;
	padding: 5em 0 0 0;
	color: white;
	}
		body {
			margin: 0;
			padding: 0;
			border: 0;
			background: no-repeat linear-gradient(27deg, rgba(149, 146, 146, 0.7) 30%, rgb(103, 102, 102) 70%);
			background: rgba(0, 0, 0, 0.9);
			min-height: 100vh;
		}

		#imageslider {
			display: flex;
			justify-content: center;
			-moz-perspective: 1000px;
			perspective: 1000;
			-moz-perspective-origin: 50% 100px;
			perspective-origin: 50% 100px;
			margin: 0;
			padding: 7em 0 0 0;
			width: 100%;
			height: 20em;
		}

		#imageslider ul {
			list-style-type: none;
			padding: 0;
			position: relative;
			margin: 0 auto;
			height: 281px;
			width: 450px;
			-moz-transform-style: preserve-3d;
			transform-style: preserve-3d;
			-moz-transform-origin: 50% 100px 0;
			transform-origin: 50% 100px 0;
			-moz-transition: all 1.0s ease-in-out;
			transition: all 1.0s ease-in-out;
		}

		#imageslider ul li {
			position: absolute;
			height: 281px;
			width: 450px;
			padding: 0px;
		}

		#imageslider ul li img {
			height: 20em;
			width: 28em;
		}

		/*第一張角度*/
		#imageslider ul li:nth-child(1) {
			-moz-transform: translateZ(225px);
			transform: translateZ(225px);
		}

		/*第二張角度*/
		#imageslider ul li:nth-child(2) {
			-moz-transform: rotateY(90deg) translateZ(225px);
			transform: rotateY(90deg) translateZ(225px);
		}

		/*第三張角度*/
		#imageslider ul li:nth-child(3) {
			-moz-transform: rotateY(180deg) translateZ(225px);
			transform: rotateY(180deg) translateZ(225px);
		}

		/*第四張角度*/
		#imageslider ul li:nth-child(4) {
			-moz-transform: rotateY(-90deg) translateZ(225px);
			transform: rotateY(-90deg) translateZ(225px);
		}

		#imageslider.transparency img {
			opacity: 0.7;
		}

		#imageslider+div {
			display: flex;
			justify-content: center;
			margin: 0.5em 0em;
		}

		#imageslider+div input[type="range"] {
			width: 20em;
		}

		/* input range 主體 */
		#seekAudioTime {
			-webkit-appearance: none;
			cursor: pointer;
			height: 1em;
		}

		/* 滑動鈕 */
		#seekAudioTime::-webkit-slider-thumb {
			-webkit-appearance: none;
			border: 1px solid #757575;
			height: 1.5em;
			width: 1em;
			border-radius: 0px;
			background: #c5c5c5;
			cursor: pointer;
			margin-top: -0.25em;
			box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
		}

		/* 滑動軌道*/
		#seekAudioTime::-webkit-slider-runnable-track {
			height: 1em;
			background: no-repeat linear-gradient(27deg, #757575 30%, #a7a7a7 70%);
		}

		#seekAudioTime:focus {
			outline: none;
		}

		/*時間顯示*/
		#playAudioTime {
			text-align: center;
			font-size: 2em;
			margin: 0.2em 0 0.5em 0;
			height: 37px;
			color: #a7a7a7;
		}

		/*音樂按鈕*/
		.audiobag {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: space-evenly;
			position: relative;
		}

		.audiobag>:nth-child(3) {
			margin: 0.5em 0;
			background: no-repeat linear-gradient(45deg, #757575 30%, #a7a7a7 70%);
			border-radius: 5px;
			box-shadow: rgba(50, 50, 93, 0.25) 0px 30px 60px -12px inset, rgba(0, 0, 0, 0.3) 0px 18px 36px -18px inset;
		}

		.nextprevWidth {
			display: flex;
			justify-content: center;
			align-items: center;
			width: 100%;
			max-width: 25em;
		}

		#prevcss>button,
		#nextcss>button {
			font-size: 2.5em;
			box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px,
				rgba(0, 0, 0, 0.3) 0px 30px 60px -30px,
				rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
		}

		#prevcss>button {
			margin-right: 0.5em;
			background: no-repeat linear-gradient(45deg, #858484 30%, #424242 70%);
			border-radius: 0.5em 0 0 0.5em;
		}

		#nextcss>button {
			margin-left: 0.5em;
			background: no-repeat linear-gradient(-45deg, #858484 30%, #424242 70%);
			border-radius: 0 0.5em 0.5em 0;
		}

		#transparency {
			display: flex;
			justify-content: center;
			margin: 0;
		}

		#playBtn {
			display: flex;
			justify-content: center;
			align-items: center;
			width: 4em;
			height: 4em;
			/*border:2px solid #0e0d0d;*/
			border-radius: 100%;
			background: no-repeat linear-gradient(90deg, #858484 30%, #424242 70%);
			box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px,
				rgba(87, 84, 84, 0.3) 0px 30px 60px -30px,
				rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
		}

		#playBtn img {
			width: 2.5em;
		}

		/*音樂按鈕 END*/

		/*歌曲列表*/
		#songlist {
			margin-top: 1em;
			display: flex;
			flex-direction: column;
			align-items: center;
			color: #a7a7a7;
		}
		#songBanner {
			display: flex;
			width: 20.75em;
			padding: 0em;
			position: absolute;
			left: -300px;
			top: 5em;
		}

		.leftside {
			width: 18.75em;
		}

		.rightside {
			border-radius: 0 5px 5px 0;
			font-size: 1.5em;
			text-align: center;
			width: 2em;
			background: no-repeat linear-gradient(45deg, #757575 30%, #a7a7a7 70%);
			position: relative;
			height: 5.5em;
			color: rgb(236, 235, 235);
		}

		.songbag {
			display: flex;
			justify-content: center;
			align-items: center;
		}

		.songcolumnbag {
			display: flex;
			justify-content: center;
			align-items: center;
			width: 300px;
			color: aliceblue;
			background: rgba(255, 253, 253, 0.2);
			opacity: 0.7;
			box-shadow: rgb(73, 73, 73) 0px 20px 30px -10px;

		}

		.songcolumnbag:hover {
			opacity: 1;
			box-shadow: rgb(204, 219, 232) 3px 3px 6px 0px inset, rgba(255, 255, 255, 0.5) -3px -3px 6px 1px inset;
		}

		.songcolumnbag>:nth-child(1n+1):not(:nth-last-child(1)) {
			margin-right: 0.1em;
		}

		.songcolumnbag>:nth-child(1n+1):not(:nth-last-child(1)) {
			margin-right: 0.2em;
		}

		.songcolumnbag>:nth-child(2) {
			cursor: pointer;
		}

		.songcolumnbag .playAudioTime {
			display: flex;
			align-items: center;
			margin: 1em 0;
			justify-content: space-evenly;
			min-width: 12.5em;
			height: 32px;
			color: white;
			background: rgba(0, 0, 0, 0.5);
			background: no-repeat linear-gradient(45deg, #757575 30%, #a7a7a7 70%);
			white-space: nowrap;
			overflow: hidden;
		}

		#volumerange {
			height: 25px;
			width: 4em;
			margin: 0 0.2em;
		}

		#playBtn,
		#prevcss>button,
		#nextcss>button,
		#loopBtn,
		#volumeBtn {
			cursor: pointer;
		}

		#songcolumnimg {
			width: 2em;
		}

		/*歌曲列表 END*/

		@media (max-width: 600px) {
			#imageslider {
				height: 15em;
			}

			#imageslider ul li {
				height: 210.025px;
				width: 337.5px;
			}

			#imageslider ul {
				height: 210.025px;
				width: 337.5px;
			}

			#imageslider ul li img {
				height: 15em;
				width: 21em;
			}

			/*第一張角度*/
			#imageslider ul li:nth-child(1) {
				-moz-transform: translateZ(168.75px);
				transform: translateZ(168.75px);
			}

			/*第二張角度*/
			#imageslider ul li:nth-child(2) {
				-moz-transform: rotateY(90deg) translateZ(168.75px);
				transform: rotateY(90deg) translateZ(168.75px);
			}

			/*第三張角度*/
			#imageslider ul li:nth-child(3) {
				-moz-transform: rotateY(180deg) translateZ(168.75px);
				transform: rotateY(180deg) translateZ(168.75px);
			}

			/*第四張角度*/
			#imageslider ul li:nth-child(4) {
				-moz-transform: rotateY(-90deg) translateZ(168.75px);
				transform: rotateY(-90deg) translateZ(168.75px);
			}

			#playAudioTime {
				display: flex;
				justify-content: center;
				align-items: center;
				font-size: 1.5em;
			}
		}
	</style>
	<script>

		$(document).ready(init);

		var songdata =[
			{
				id: '',
				productId: '',
				name: '',
				src: '',
				photo: ''
			},
			<% if (list !=null && list.size()> 0) {

			    for (int i = 0; i < list.size(); i++) { 
			        	  Product p=list.get(i); %>
				{
					id: '<%=i+1%>',
					productId: '<%=p.getId()%>',
					name: '<%=p.getName()%>',
					src: '<%=request.getContextPath()%>/<%=p.getMusicUrl()%>',
					photo: '<%=request.getContextPath()%>/<%=p.getPhotoUrl()%>'
				},<%}}%>
			{
				id: '',
				productId: '',
				name: '',
				src: '',
				photo: ''
			},
			{
				id: '',
				productId: '',
				name: '',
				src: '',
				photo: ''
			}];

		var rotateY = 0;
		var thismusic = 1;
		var index = Number($("#imageslider ul li").attr("aspectIndex"));//get index number
		var songcolumnindex = 1;
		var audiovisual = $("#audiovisual")[0];
		var toggle = true;
		function toggleHandler() {
			//alert("點");
			if (toggle) {
				$("#songBanner").animate({ left: "0px" }, 300);
			} else {

				$("#songBanner").animate({ left: "-300px" }, 300);
			}
			toggle = !toggle;
		}
		
		function seekAudioTime() {
			//lert($("#seekAudioTime").val());
			//seekAudioTime的值=音樂播放的時間
			audiovisual.currentTime = $("#seekAudioTime").val();
		}


		function prevBtnHandler() {
			//alert("上一首");
			//向左轉90度
			rotateY -= -90;
			//上一首音樂
			thismusic--;
			//第一首時上一首按鈕關閉
			if (thismusic == 1) {
				$("#prevBtn").off("click", prevBtnHandler);
				$("#prevBtn").css("opacity", "0.2");
				$('#prevBtn').css('cursor', 'default');
			}
			//下一首按鈕關閉時變開啟
			if ($("#nextBtn").css("opacity") == 0.2) {
				$("#nextBtn").on("click", nextBtnHandler);
				$("#nextBtn").css("opacity", "1");
				$('#nextBtn').css('cursor', 'pointer');
			}
			//操控第幾面
			if (index > 0) {
				index--;
			} else {
				index = 3;
			}
			//換成上一首歌路徑
			$('#audiovisual').attr("src", songdata[thismusic].src);
			//按上一首自動撥放
			if (audiovisual.paused) {
				PlayPauseHandler();
			}
			audiovisual.autoplay;
			//所有changemuisc播放按鈕圖變三角形
			$(".changemuisc img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
			//立體方塊圖片轉換
			if (index == 0) {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic + 1].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic + 2].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic - 1].photo);
			} else if (index == 1) {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic - 1].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic + 1].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic + 2].photo);
			}
			else if (index == 2) {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic + 2].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic - 1].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic + 1].photo);
			} else {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic + 1].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic + 2].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic - 1].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic].photo);
			}
			//立體方塊轉角度
			$("#imageslider ul").css({
				"transform": "rotateY(" + rotateY + "deg)"
			});
			//按上一首透明度關閉
			$("#imageslider").toggleClass("transparency", false);
		}

		function nextBtnHandler() {
			//alert("下一首");
			//向右轉90度
			rotateY -= 90;
			//下一首音樂
			thismusic++;
			//最後一首時下一首按鈕關閉
			if (thismusic == (songdata.length - 3)) {
				$("#nextBtn").off("click", nextBtnHandler);
				$("#nextBtn").css("opacity", "0.2");
				$('#nextBtn').css('cursor', 'default');
			}
			//上一首按鈕關閉時變開啟
			if ($("#prevBtn").css("opacity") == 0.2) {
				$("#prevBtn").on("click", prevBtnHandler);
				$("#prevBtn").css("opacity", "1");
				$('#prevBtn').css('cursor', 'pointer');
			}
			//操控第幾面
			if (index < 3) {
				index++;
			} else {
				index = 0;
			}
			//換成下一首歌路徑
			$('#audiovisual').attr("src", songdata[thismusic].src);
			//按下一首自動撥放
			if (audiovisual.paused) {
				PlayPauseHandler();
			}
			audiovisual.autoplay;
			//所有changemuisc播放按鈕圖變三角形
			$(".changemuisc img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
			//立體方塊圖片轉換
			if (index == 0) {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic + 1].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic + 2].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic - 1].photo);
			} else if (index == 1) {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic - 1].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic + 1].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic + 2].photo);
			} else if (index == 2) {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic + 2].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic - 1].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic + 1].photo);
			} else {
				$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic + 1].photo);
				$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic + 2].photo);
				$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic - 1].photo);
				$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic].photo);
			}
			//立體方塊轉角度
			$("#imageslider ul").css({
				"transform": "rotateY(" + rotateY + "deg)"
			});
			//按下一首透明度關閉
			$("#imageslider").toggleClass("transparency", false);
		}

		function Achangemuisc(themusic) {
			//alert($(themusic).attr('songcolumnindex'));
			//指定為第songcolumnindex首歌
			thismusic = $(themusic).attr('songcolumnindex');
			//角度=這首歌乘-90度
			rotateY = thismusic * -90;
			//算立體方塊的值
			if ((rotateY / 90) % 4 == 0) {
				index = 0;
			} else if ((rotateY / 90) % 4 == -1) {
				index = 1;
			} else if ((rotateY / 90) % 4 == -2) {
				index = 2;
			} else {
				if ((rotateY / 90) % 4 == -3) {
					index = 3;
				}
			}
			//上下一首按鈕關閉時變開啟
			if ($("#prevBtn").css("opacity") == 0.2) {
				$("#prevBtn").on("click", prevBtnHandler);
				$("#prevBtn").css("opacity", "1");
				$('#prevBtn').css('cursor', 'pointer');
			} else {
				if ($("#nextBtn").css("opacity") == 0.2) {
					$("#nextBtn").on("click", nextBtnHandler);
					$("#nextBtn").css("opacity", "1");
					$('#nextBtn').css('cursor', 'pointer');
				}
			}

			//$("#imageslider ul").css({
			//	"transform": "rotateY(" + rotateY + "deg)"
			//});

			//第一首或最後一首時按鈕關閉
			if (thismusic == 1) {
				$("#prevBtn").off("click", prevBtnHandler);
				$("#prevBtn").css("opacity", "0.2");
				$('#prevBtn').css('cursor', 'default');
			} else {
				if (thismusic == (songdata.length - 3)) {
					$("#nextBtn").off("click", nextBtnHandler);
					$("#nextBtn").css("opacity", "0.2");
					$('#nextBtn').css('cursor', 'default');
				}
			}
			//播放按鈕圖變||
			$("#playBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
			//換成這首圖片
			$("#imageslider ul li").children().attr("src", $(themusic).attr('data-photo'));
			//換成這首音樂路徑
			$('#audiovisual').attr("src", $(themusic).attr('data-src'));
			//按這首透明度關閉
			$("#imageslider").toggleClass("transparency", false);
			//播放音樂
			PlayPauseHandler();
		}

		function Achangeing(theimg) {
			//其他changemuisc播放按鈕圖變三角形
			$(".changemuisc img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
			//changemuisc播放按鈕圖變||
			$(theimg).attr("src", "<%=request.getContextPath()%>/images/audio/pause.png");
		}

		$("#transparency").click(function () {
			$("#imageslider").toggleClass("transparency");
		});

		function init() {
			$("#songBanner .rightside").click(toggleHandler);
			//上一首按鈕初始狀態為關閉
			if (rotateY == 0) {
				$("#prevBtn").off("click", prevBtnHandler);
				$("#prevBtn").css("opacity", "0.2");
				$('#prevBtn').css('cursor', 'default');
			}
			//$("#prevBtn").click(prevBtnHandler);
			//下一首按鈕開關
			$("#nextBtn").click(nextBtnHandler);
			//轉動速度
			$('#imageslider ul').css('transition-duration', '0.7s');
			//audiovisual初值為第一首
			$('#audiovisual').attr("src", songdata[1].src);
			//playAudioTime初值為第一首歌名
			$("#playAudioTime").text(songdata[1].name);
			//imageslider ul li 第一面初值第一首歌圖
			$("#imageslider ul li").children().eq(0).attr("src", songdata[thismusic].photo);
			//imageslider ul li 第二面初值第二首歌圖
			$("#imageslider ul li").children().eq(1).attr("src", songdata[thismusic + 1].photo);
			//imageslider ul li 第三面初值第三首歌圖
			$("#imageslider ul li").children().eq(2).attr("src", songdata[thismusic + 2].photo);
			//imageslider ul li 第四面初值第四首歌圖
			$("#imageslider ul li").children().eq(3).attr("src", songdata[thismusic + 3].photo);
			//循環播放開關
			$("#loopBtn").click(LoopHandler);
			//設定seekAudioTime初值
			$("#seekAudioTime").val(0);
			//設定音量滑條初值
			$('#audiovisual').prop("volume", ($("#volumerange").val() / 100));
			//撥放按鈕開關
			$("#playBtn").click(PlayPauseHandler);
			//音量滑條操控
			$("#volumerange").click(volumeUpDownHandler);
			//靜音按鈕
			$("#volumeBtn").click(volumeMuted);
			// $("#audiovisual").on("timeupdate", timeUpdate);
			//播放時啟動方法
			$("#audiovisual").on("play", startPlayHandler);
			//暫停時啟動方法
			$("#audiovisual").on("pause", stopPlayHandler);
			//結束時啟動方法
			$("#audiovisual").on("ended", endedPlay);

		}

		function PlayPauseHandler() {
			if (audiovisual.paused) {
				//alert("播放");
				//audiovisual.currentTime = 0;
				//音樂播放
				audiovisual.play();
				//播放按鈕圖變||
				$("#playBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/pause.png");
				//播放時啟用timeUpdate方法
				$("#audiovisual").on("timeupdate", timeUpdate);
			} else {
				//alert("暫停");
				//暫停時播放按鈕圖變三角形
				$("#playBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
				//暫停時changemuisc播放按鈕圖變三角形
				$(".changemuisc img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
				//音樂暫停
				audiovisual.pause();
			}
		}

		function LoopHandler() {
			//切換循環開關
			if ($("#loopBtn").attr("data-control") == "auto") {
				$("#loopBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/loop1.png");
				$("#loopBtn").attr("data-control", "loop");
				audiovisual.loop = true;
			} else {
				audiovisual.loop = false;
				$("#loopBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/loop.png");
				$("#loopBtn").attr("data-control", "auto");
			}
		}

		function volumeMuted() {
			//alert("靜音");
			//點擊靜音
			audiovisual.muted = true;
			//聲音滑條值變0
			$("#volumerange").val(0);
			//換成靜音圖
			$("#volumeBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/muted.png");
		}

		function startPlayHandler() {
			//alert("歌名");
			//播放按鈕圖變||
			$("#playBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/pause.png");
			//播放時playAudioTime換成這首歌名
			$("#playAudioTime").text(songdata[thismusic].name);
		}

		function stopPlayHandler() {
			//暫停時playAudioTime換成這首歌名
			$("#playAudioTime").text(songdata[thismusic].name);
		}

		function endedPlay() {
			//結束時playAudioTime換成這首歌名
			$("#playAudioTime").text(songdata[thismusic].name);
			//結束時播放按鈕圖變三角形
			$("#playBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
			//結束時changemuisc播放按鈕圖變三角形
			$(".changemuisc img").attr("src", "<%=request.getContextPath()%>/images/audio/play1.png");
			//不是最後一首結束後播放下一首  與是最後一首結束後變透明
			if (thismusic != (songdata.length) - 3) {
				if (audiovisual.ended) {
					nextBtnHandler();
				}
			}else{
				if (audiovisual.ended) {
					$("#imageslider").toggleClass("transparency", true);
				}
			}
		}

		function timeUpdate() {
			//滑條=Time屬性的值
			$("#seekAudioTime").val($("#seekAudioTime").attr("Time"));
			//Time屬性的值=音樂時間
			$("#seekAudioTime").attr("Time", audiovisual.currentTime);
			//滑條最大值=總音樂時間
			$("#seekAudioTime").attr("max", audiovisual.duration);
			//顯示時間
			$("#playAudioTime").text(timeConvert(audiovisual.currentTime)
				+ " / " + timeConvert(audiovisual.duration));
		}

		function timeConvert(time) {
			//時間分數
			var mins = parseInt(time / 60);
			//時間秒數
			var secs = parseInt(time % 60);
			//時間秒數轉換成00:00
			if (secs < 10) secs = "0" + secs;
			return mins + ":" + secs;
		}

		function volumeUpDownHandler() {
			//alert($("#volumerange").val());
			//取音量滑條值
			var volumesound = $("#volumerange").val();
			//提示顯示為音量滑條值
			var title = $('#volumerange').attr('title', volumesound);
			//音量設定
			if (volumesound != 0) {
				$("#volumeBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/volume.png");
				audiovisual.muted = false;
				volumesound /= 100;
			} else {
				$("#volumeBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/muted.png");
			}
			//音樂=音量滑條值
			audiovisual.volume = volumesound;
		}

	</script>
</body>
</html>