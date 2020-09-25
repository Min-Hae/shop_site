<%@page import="kr.shop.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<br>
고객님 마음껏 쇼핑하세요!!!
<p/>
<%@ include file="guest_top.jsp" %>
<table style="width: 90%">
  <tr><!-- ajax를 운영하여 상품명 위에 마우스를 올렸을 때 가격과 재고량이 나오도록 할 수도 있음 -->
    <th>상품명</th><th>가격</th><th>재고량</th><th>상세보기</th>
  </tr>
  <%
  ArrayList<ProductDto> list = productMgr.getProductAll();
  for(ProductDto p:list){
  %>
  <tr style="text-align: center;">
    <td>
    	<img src="../upload/<%=p.getImage() %>" width="80" />&nbsp;&nbsp;&nbsp;&nbsp;
    	<%=p.getName() %>
    </td>
    <td>
    	<%=p.getPrice() %>
    </td>
    <td>
    	<%=p.getStock() %>
    </td>
    <td>
    	<a href="javascript:productDetail_guest('<%=p.getNo() %>')">보기</a>
    </td>
  </tr>
  <%
  }
  %>
</table>
<%@ include file="guest_bottom.jsp" %>

<form action="productdetail_g.jsp" name="detailFrm" method="post">	<!-- detailFrm : script.js-productDetail_guest() 에서 지정한 이름 -->
  <input type="hidden" name="no">
</form>
</body>
</html>