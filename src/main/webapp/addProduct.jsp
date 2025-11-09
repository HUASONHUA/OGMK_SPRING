<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Customer"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增商品</title>
<style>
body {
  font-family: Arial, sans-serif;
  margin: 20px;
}
label {
  display: inline-block;
  width: 120px;
  margin-top: 8px;
}
input, select, textarea {
  margin-top: 8px;
}
.section {
  border: 1px solid #ccc;
  padding: 15px;
  margin: 15px 0;
  border-radius: 8px;
}
.merchGroup {
  border: 2px solid #666;
  padding: 12px;
  margin: 15px 0;
  border-radius: 8px;
  background: #f9f9f9;
}

.size {
  padding: 0 10px;
  margin: 10PX 0 0 0;
  background: #e9e1e1;
}
.sizeGroup {
  padding: 10px;
  margin: 0 0 10px 0;;
  background: #e9e1e1;
}
</style>
<script>
  function toggleFields() {
    const mainCategory = document.getElementById("mainCategory").value;
    document.getElementById("musicCategoryDiv").style.display = mainCategory==="music"?"block":"none";
    document.getElementById("merchFields").style.display = mainCategory==="merch"?"block":"none";
  }

  let merchIndex = 0;
  function addMerch() {
    const container = document.getElementById("merchContainer");
    const div = document.createElement("div");
    div.className = "merchGroup";
    div.setAttribute("data-index", merchIndex);
    merchIndex++;

    div.innerHTML = `
        <h4>周邊商品種類</h4>
        <label>種類名稱：</label><input type="text" name="typeColorName"><br>
        <label>顏色圖片 URL：</label><input type="text" name="colorPhotoUrl"><br>
        <label>ICON URL：</label><input type="text" name="iconUrl"><br>
        <label>種類庫存：</label><input type="number" name="typeStock"><br>

        <div class="size">尺寸設定</div>
        <div class="sizeContainer"></div>
        <button type="button" onclick="addSize(this)">新增尺寸</button>
        <button type="button" onclick="this.parentElement.remove()">刪除此種類</button>
    `;
    container.appendChild(div);
  }

  function addSize(btn) {
    const group = btn.closest(".merchGroup");
    const index = group.getAttribute("data-index");
    const container = group.querySelector(".sizeContainer");
    console.log("addSize :"+index);
    const div = document.createElement("div");
    div.className = "sizeGroup";
    div.innerHTML = `
        <label>尺寸：</label><input type="text" name="size_\${index}"><br>
        <label>庫存：</label><input type="number" name="stock_\${index}"><br>
        <label>單價：</label><input type="number" step="0" name="merchUnitPrice_\${index}"><br>
        <label>排序號：</label><input type="number" name="ordinal_\${index}"><br>
        <button type="button" onclick="this.parentElement.remove()">刪除此尺寸</button>
    `;
    console.log(`size_${index}`);
    container.appendChild(div);
  }
</script>
</head>

<body>
<%
  Customer member = (Customer)session.getAttribute("member");
  if (member != null) {
    boolean admin = member.isAdmin();
    if (admin) {
%>
  <h2>新增商品</h2>
  <form action="addProduct" method="post">
    <div class="section">
      <h3>基本商品資訊</h3>
      <label>商品名稱：</label><input type="text" name="name" required><br>
      <label>歌手/品牌：</label><input type="text" name="singer"><br>
      <label>描述：</label><textarea name="description" rows="3" cols="40"></textarea><br>
      <label>折扣：</label><input type="number" step="0" name="discount" value="0"><br>
      <label>封面圖片 URL：</label><input type="text" name="photoUrl"><br>
      <label>商品類別：</label>
      <select name="mainCategory" id="mainCategory" onchange="toggleFields()" required>
        <option value="">請選擇</option>
        <option value="music">音樂</option>
        <option value="merch">周邊商品</option>
      </select><br>
    </div>

  <!-- 音樂商品細分類 -->
    <div id="musicCategoryDiv" class="section" style="display:none;">
      <h3>音樂商品資訊</h3>
      <label>音樂分類：</label>
      <select name="category">
        <option value="JPOP">JPOP</option>
        <option value="ANIME">ANIME</option>
        <option value="VOCALOID">VOCALOID</option>
        <option value="VTuber">VTuber</option>
      </select><br>
      <label>音樂檔案 URL：</label><input type="text" name="musicUrl"><br>
      <label>試聽檔案 URL：</label><input type="text" name="auditionUrl"><br>
      <label>單價：</label><input type="number" step="0" name="unitPrice"><br>
      <input type="hidden" name="stock" value="1"><br>
    </div>

    <!-- 周邊商品欄位 -->
    <div id="merchFields" class="section" style="display:none;">
      <h3>周邊商品資訊</h3>
      <div id="merchContainer"></div>
      <button type="button" onclick="addMerch()">新增周邊種類</button>
    </div>

    <div style="margin-top:20px;">
      <button type="submit">送出</button>
      <button type="reset">清除</button>
    </div>
  </form>
  <% } else { %>
    <h3>帳號無此權限</h3>
  <% } %>
<% } else { %>
  <h3>無此權限</h3>
<% } %>
</body>
</html>
