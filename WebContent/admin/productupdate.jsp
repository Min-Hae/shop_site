<%@page import="kr.shop.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />
<% ProductDto dto = productMgr.getProduct(request.getParameter("no")); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자:상품수정</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="margin-top: 20px">
<%@include file="admin_top.jsp" %> <!-- session 써먹는중. session만료시 로그인화면으로 돌아감 -->

<form action="productproc.jsp?flag=update" enctype="multipart/form-data" method="post"><!-- file이 넘어가는데 get방식을 쓸 수는 없음 -->
<table style="width: 90%">
  <tr><th colspan="2">* 상품 수정 *</th></tr>
  <tr>
    <td>상품명</td>
    <td><input type="text" name="name" value="<%=dto.getName() %>"></td>
  </tr>
  <tr>
    <td>가 격</td>
    <td><input type="text" name="price" value="<%=dto.getPrice() %>"></td>
  </tr>
  <tr>
    <td>설 명</td>
    <td><textarea rows="5" cols="60" name="detail"><%=dto.getDetail() %></textarea></td>
  </tr>
  <tr>
    <td>재고량</td>
    <td><input type="text" name="stock" value="<%=dto.getStock() %>"></td>
  </tr>
  <tr>
    <td>이미지</td>
    <td>
    	<img src="../upload/<%=dto.getImage() %>" width="50">
    	<input type="file" name="image" size="50">
    </td>
  </tr>
  <tr>
    <td colspan="2" style="text-align: center;">
    	<br>
    	<input type="hidden" name="no" value="<%=dto.getNo() %>">
    	<input type="submit" value="상품 수정">
    	<input type="button" value="수정 취소" onclick="history.back()">
    </td>
  </tr>
</table>  
</form>

<%@include file="admin_bottom.jsp" %>
</body>
</html>