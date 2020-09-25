
<%@page import="kr.shop.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="margin-top: 10px;">
**관리자 : 전체 상품 목록**
<br>
<%@include file="admin_top.jsp" %>
<table style="width: 90%">
  <tr><td colspan="6">
  	<a href="productinsert.jsp">[ 상품 등록 ]</a>
  </td></tr>
  <tr style="background-color: yellow;">
    <th>번호</th><th>상품명</th><th>가격</th><th>등록일</th><th>재고량</th><th>상세보기</th>
  </tr>
  <%
  ArrayList<ProductDto> list = productMgr.getProductAll();
  if(list.size() == 0){ 
  %>
  <tr><td colspan="6">등록된 상품이 없습니다</td></tr>
  <%		  
  }else{
	 for(ProductDto p:list){
  %>
  <tr style="text-align: center;">
  	<td><%=p.getNo() %></td>
  	<td><%=p.getName() %></td>
  	<td><%=p.getPrice() %></td>
  	<td><%=p.getSdate() %></td>
  	<td><%=p.getStock() %></td>
  	<td>
  		<a href="javascript:productDetail('<%=p.getNo() %>')">보기</a>
  	</td>	
  </tr>
  <%
	 }
  }
  %>
</table>
<%@include file="admin_bottom.jsp" %>

<form action="productdetail.jsp" name="detailForm" method="post">
<input type="hidden" name="no">
</form>
</body>
</html>



