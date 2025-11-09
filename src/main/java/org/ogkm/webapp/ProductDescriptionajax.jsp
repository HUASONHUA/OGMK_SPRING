<%@page import="org.ogkm.entity.Outlet"%>
<%@page import="org.ogkm.service.ProductService"%>
<%@page import="org.ogkm.entity.Product"%>
<%@ page  pageEncoding="UTF-8"%>
<!--ajax -->
<script>
	function submitCart(theForm) {
		// 	alert($("#qty").val());
		// 	console.log("input[name='qty']: " + $("input[name='qty']").val());
		// 	alert("#cartForm serialize(): " + $("#cartForm").serialize());				
		if (!theForm.submited) {
			$.ajax({
				url: $(theForm).attr('action') + "?ajax=",
				method: 'POST',
				data: $(theForm).serialize()
			}).done(submitCartDoneHandler);

			return false; //false取消原來同步的submit功能, true還原原來同步的submit功能		
		}
	}

	function submitCartDoneHandler(data, status, xhr) {
		// 	alert("加入購物車成功!" + data.totalQty);
		$(".cartQty").html(data.totalQty);
	}

	$(document).ready(init);

	function init() {
		var audiovisual = $("#audiovisual")[0];
		$('#audiovisual').prop("volume", ($("#volumerange").val() / 100));
		$("#playBtn").click(PlayPauseHandler);
		$("#volumerange").click(volumeUpDownHandler);
		$("#volumeBtn").click(volumeMuted);
		$("#audiovisual").on("timeupdate", timeUpdateHandler);
		$("#audiovisual").on("play", startendedPlayHandler);
		$("#audiovisual").on("pause", startendedPlayHandler);
		$("#audiovisual").on("ended", startendedPlayHandler);
		submitCart(theForm);
	}

	function PlayPauseHandler() {
		if (audiovisual.paused) {
			//         alert("播放");
			audiovisual.currentTime = 0
			audiovisual.play();
			$("#playBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/pause.gif");

		} else {
			//         alert("暫停");
			$("#playBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/play.png");
			audiovisual.pause();
		}

	}
	function volumeMuted() {
		//     alert("靜音");
		audiovisual.muted = true;
		$("#volumerange").val(0);
		$("#volumeBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/muted.png");
	}


	function startendedPlayHandler() {
		//      alert("歌名");
		var playAudioname = $("#playAudioname").text();
		$("#playAudioTime").text(playAudioname);
	}

	function timeUpdateHandler() {
		$("#playAudioTime").html(timeConvert(audiovisual.currentTime)
			+ " / " + timeConvert(audiovisual.duration));
	}
	function timeConvert(time) {
		var mins = parseInt(time / 60);
		var secs = parseInt(time % 60);
		if (secs < 10) secs = "0" + secs;
		return mins + ":" + secs;
	}

	function volumeUpDownHandler() {
		//     alert($("#volumerange").val());
		var volumesound = $("#volumerange").val();
		var title = $('#volumerange').attr('title', volumesound);
		if (volumesound != 0) {
			$("#volumeBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/volume.png");
			audiovisual.muted = false;
			volumesound /= 100;
		} else {
			$("#volumeBtn img").attr("src", "<%=request.getContextPath()%>/images/audio/muted.png");
		}
		audiovisual.volume = volumesound;
	}

</script>
<div class="observebag">
	<% String productId=request.getParameter("productId"); 
	Product p=null; 
	if(productId!=null){ 
		ProductService ps=new ProductService();
		p=ps.getSelectProductsById(productId); 
		} if(p==null){ %>
		<p>查無此商品(id=<%=productId %>)</p>
		<%}else{ %>

			<%--<%=p%> --%>
				<article class="Descriptionbag">
					<img src="<%=p.getPhotoUrl()%>">
					<div class="ProductDescription">
						<div id="playAudioname">
							<%=p.getName()%>
						</div>
						<div>
							<%=p.getSinger()%>
						</div>
						<div>上架日期:<%=p.getShelfDate()%>
						</div>
						<div>曲數:1</div>
						<div>折扣:<%=p instanceof Outlet?((Outlet)p).getDiscountString():"--"%>
						</div>
						<div>價格:NT <%=p.getUnitPrice()%>
						</div>
					</div>

				</article>
				<form id='cartForm' action="add_to_cart.do" method="POST" onsubmit="return submitCart(this)">
					<input type='hidden' value='<%=p.getId() %>' name='productId'>
					<table class="Auditionbag">
						<thead>
							<tr>
								<th>順序</th>
								<th>歌曲</th>
								<th>數量</th>
								<th>歌手</th>
								<th>購買</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td><%=p.getName() %></td>
								<td>
									<input type="hidden" name="quantity" value='<%= p.getStock()%>'>
									<%= p.getStock()%>
								</td>
								<td><%=p.getSinger()%></td>
								<td>
									<input type="submit" onclick='this.form.submited=true;'
										value='NT<%= p.getUnitPrice()%>'>
								</td>
							</tr>

							<tr>
								<td colspan="1">試聽</td>
								<!--音樂 -->
								<td colspan="3">

									<div class="audiovisualbag">
										<audio id="audiovisual"
											src="<%=request.getContextPath()%>/<%=p.getAuditionUrl()%>"
											type="audio/mpeg">
										</audio>
										<a id="playBtn"><img src="<%=request.getContextPath()%>/images/audio/play.png"></a>
										<div id="playAudioTime"><%=p.getName() %></div>
										<a id="volumeBtn"><img src="<%=request.getContextPath()%>/images/audio/volume.png"></a>
										<input id="volumerange" ontouchmove="volumeUpDownHandler()" type="range"
											value="25" min="0" max="100">
									</div>
								</td>

								<td colspan="1">
									<button type="submit" title="加入購物車">
										<i class="fas fa-cart-arrow-down"> 
										<span class='cartQty'>
										${sessionScope.cart.getTotalQuantity()}
										</span></i>
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="singerRelated">
					<%=p.getDescription() %>
				</div>
				<%} %>
</div>
<!--內容結束-->
<style>
	.observebag {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: flex-start;
		width: 100%;
		padding: 0em 0em 0 0em;
		min-height: 72vh;
	}

	.Descriptionbag {
		display: flex;
		justify-content: center;
		width: 100%;
		margin: 0 0 1em 0;
	}

	.Descriptionbag img {
		width: 20em;
	}

	.ProductDescription {
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		align-items: flex-start;
		margin: 0 0 0 2em;
	}

	.Auditionbag {
		width: 100%;
		border-top: 0.2em solid gray;
		text-align: center;
		margin-bottom: 1em;
	}

	.Auditionbag tbody tr:nth-child(1) td:nth-child(3) input {
		width: 1em;
	}

	.Auditionbag tbody tr:nth-child(2) {
		border-top: 1px solid #eee;
	}
	button .cartQty{
	color:red;
	}

	.singerRelated {
    text-align:center;
      margin: 0 0em 1em 0;
      max-width: 30em;
    }

	/*試聽*/
	.audiovisualbag {
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}

	.audiovisualbag>:nth-child(1n+1):not(:nth-last-child(1)) {
		margin-right: 0.5em;
	}

	#playAudioTime {
		display: flex;
		justify-content: space-evenly;
		align-items:center;
		min-width: 12.5em;
		height:1.5em;
		color: white;
		background: rgba(0, 0, 0, 0.5);
		white-space: nowrap;
		overflow: hidden;
	}

	#volumerange {
		width: 4em;
	}

	/*試聽 END*/
	/**/
	@media (max-width : 800px) {
		.observebag {
			display: flex;
			flex-direction: column;
		}

		.Descriptionbag {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
		}

		.ProductDescription {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: flex-start;
			margin: 1em 0 0 0em;
		}

		.ProductDescription div {
			margin: 0.5em 0 0 0em;
		}

		.Auditionbag tbody tr:nth-child(1) td:nth-child(2),
		.Auditionbag tbody tr:nth-child(1) td:nth-child(4) {
			width: 6.25em;
		}

		#playAudioTime {
			display: flex;
			justify-content: flex-start;
			min-width: auto;
			max-width: 5em;
		}

	}
</style>