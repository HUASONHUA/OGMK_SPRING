<%@page import="org.ogkm.OGKM_Lib.entity.TypeColor"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Outlet"%>
<%@page import="org.ogkm.OGKM_Lib.service.ProductService"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Product"%>
<%@ page  pageEncoding="UTF-8"%>
<!--ajax  -->
 <script>
  
  <% 
  String productId=request.getParameter("productId"); 
  Product p=null; 
  if(productId!=null){ 
  	ProductService ps=new ProductService(); 
  	p=ps.getSelectProductsById(productId); 
    } 
  if(p!=null){ 
  %>
  function init(){			

		var stock =<%=p.getStock()%>;
		setQtyAndSubmit(stock);
		
		<% if(p.hasSize()==true && p.isTypecolorMapEmpty()){%>
		//alert("p.hasSize() && p.isTypecolorMapEmpty()");
			getSize("");
		<%}%>
	}
  <%}%>
    function changeData(theObj) {
      //	alert($(theObj).attr("src"));
      //	alert($(theObj).attr("title"));

      $("#colorStock").text($(theObj).attr("title") + " 有" + $(theObj).attr("data-stock") + "個");
      $(".photo").attr("src", $(theObj).attr("data-photo"));
      $("#sizeStock").text("");
      $("#unitPrice").text($("#unitPrice").attr("data-price"));
      var stock = Number($(theObj).attr("data-stock"));	
		setQtyAndSubmit(stock);
		
		<% if(p!=null && p.hasSize()){%>
			getSize($(theObj).attr("title"));
		<%}%>
    }
    
    function setQtyAndSubmit(stock){	
    	//alert("");
    	$("input[name='quantity']").attr("max", stock);
		$("input[name='quantity']").attr("min", stock>0?1:0);
		$("input[type='submit']").prop('disabled', stock<=0);
		$("button[type='submit']").prop('disabled', stock<=0);
	}
    
	function changeSizeOption(sizeOption){
		//alert(Number($("select[name='size'] option:selected").attr("data-stock")));
		if($(sizeOption).val()!=""){
			$("#unitPrice").text($("select[name='size'] option:selected").attr("data-price"));
			var stock = Number($("select[name='size'] option:selected").attr("data-stock"));	
			setQtyAndSubmit(stock);
			var sizeStockData ="有" + stock + "個";
			
			$("#sizeStock").text($("select[name='size'] option:selected").val()+sizeStockData);
		}
	}
	
	function getSize(typecolorname){
		var productId = $("input[name='productId']").val();
		console.log(productId, typecolorname);
		$.ajax({
			url:'size.jsp?productId=' + productId + "&typecolorname="+typecolorname,
			method:'GET'
		}).done(getSizeDone);
	}
	
	function getSizeDone(data){
		//alert(data);
		//帶入select[name='size']
		$("select[name='size']").html(data);
	}
    
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
  </script>


<body>  
  <div class="observebag">

   <% if(p==null){ %>
      <p>查無此商品(id=<%=productId %>)</p>
      <%}else{ %>
        <%--=p--%>
          <article class="Descriptionbag">
            <img class="photo" src="<%=p.getPhotoUrl()%>">
            <div class="ProductDescription">
              <div>產品:<%=p.getName() %> </div>
              <div>歌手:<%=p.getSinger()%></div>
              <div>上架日期:<%=p.getShelfDate()%></div>
              <div>庫存:<span id='colorStock'></span><span id='sizeStock'><%=!p.isTypecolorMapEmpty()||p.hasSize()==true?"請選顏色或庫存":p.getStock()%></span> </div>
              <div >優惠價:<%=p instanceof Outlet?((Outlet)p).getDiscountString():"" %> 
              NT<span id="unitPrice" data-price="<%= p.getUnitPrice()%>"><%= p.getUnitPrice()%></span> </div>

              <form id='cartForm' class="TypeColorbag" action="add_to_cart.do" 
              method="POST" onsubmit="return submitCart(this)">
                <input type='hidden' value='<%= p.getId() %>' name='productId'>
                <% if(p.getTypecolorMapsize()>0){%>
                  <label class="typecolorlabel">類型(顏色):</label>
                  <div class="typecolor">
                    <% for(TypeColor typecolor:p.getTypecolorMapvalues()){%>
                      <label>
                        <input type='radio' name='typecolor' value='<%= typecolor.getTypecolorname() %>' required>
                        <img class='icon'
                          src="<%= typecolor.getIconUrl()==null?typecolor.getPhotourl():typecolor.getIconUrl() %>"
                          alt='產品小圖示' title='<%= typecolor.getTypecolorname()%>' onclick='changeData(this)'
                          data-stock='<%= typecolor.getStock() %>' data-photo='<%= typecolor.getPhotourl() %>'>
                      </label>
                      <% } %>
                  </div>
                  <% } 
					if(p.hasSize()){
				  %>
				  <label id='sizeStock'><%=!p.isTypecolorMapEmpty()?"請先選擇顏色":""%></label>
                  <div class="sizeBigbag">
                   <label>尺寸:</label>
                    <select class="sizebag" name='size' onchange="changeSizeOption(this)" size="1" required>
                      <option value='' disabled>請選擇</option >
				    </select>
                  </div>
                  <% } %>
                    <div class="quantitynumber">
                      <label>數量:</label>
                      <input type='number' name='quantity' 
                      value='1' min='1' max='<%= p.getStock()%>'>
                    </div>
                    <div class="shippingcartBtn">
                      <input class="Directpurchase" type="submit" 
                      onclick='this.form.submited=true;' value='直接購買'>
                      <button type="submit" title="加入購物車">
                        <i class="fas fa-cart-arrow-down"></i>
                         <span class='cartQty'>
                         ${sessionScope.cart.getTotalQuantity()}
                         </span>
                      </button>
                    </div>
              </form>
            </div>

          </article>
          <div class="singerRelated">
            <h2>產品描述</h2>
            <%=p.getDescription()%>
          </div>
          <%} %>
  </div>
  <script>
 	init();
  </script>
  <!--內容結束-->
  <style>
    .observebag {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      width: 100%;
      padding-top: 5em;
      min-height: 72vh;
    }

    .Descriptionbag {
      display: flex;
    }

    .Descriptionbag img {
      width: 20em;
    }

    /*產品明細*/
    .ProductDescription {
      display: flex;
      flex-direction: column;
      justify-content: space-around;
      align-items: flex-start;
      margin: 0 0 0 1em;
    }

    .TypeColorbag {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .typecolorlabel {
      margin: 0.5em;
    }

    .typecolor {
      display: flex;
   
    }

    [type=radio] {
      position: absolute;
      opacity: 0;
      width: 3;
      height: 1;
    }


    .typecolor label {
      margin-right: 0.5em;
    }

    .typecolor label .icon {
      width: 5em;
    }

    .typecolor label:nth-last-child(1) {
      margin: 0;
    }

    /* IMAGE STYLES */
    [type=radio]+img {
      cursor: pointer;
    }

    /* CHECKED STYLES */
    [type=radio]:checked+img {
      outline: 2px solid #000;
    }
    #sizeStock{
    color:#ff4265;
    margin: 0.2em 0;
    }
    .sizeBigbag{
     margin: 0.2em 0;
    }
    .sizebag{
    width:5.5em;
    font-size: 1em;
    }
    .quantitynumber {
      margin: 0.5em 0;
    }

    .quantitynumber input[type="number"] {
      font-size: 1em;
      width: 5em;
    }
    button .cartQty{
        color:red;
        }

    /*產品明細 END*/
    /*產品描述*/
    .singerRelated {
      padding: 1em 1em ;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      min-height: 10em;
    }

    .singerRelated h2 {
      margin: 0;
    }

    .Directpurchase {
      margin: 0 1em 0 0;
    }

    /*產品描述 END*/
    @media (max-width : 800px) {
      .Descriptionbag {
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .ProductDescription {
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        align-items: center;
        margin: 0 0 0 0em;
      }
    }
  </style>
 