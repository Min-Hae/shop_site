<%@page import="kr.shop.product.ProductDto"%>
<%@page import="kr.shop.order.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="kr.shop.order.CartMgr" scope="session" /> <!-- session에서 유효 -->
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" /><!-- order에는 상품번호만 존재하고 상품명이 없으므로 productMgr필요 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품주문</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="margin-top: 20px">
** 장바구니 목록 **<p/>
<%@ include file="guest_top.jsp" %><!-- 로그인 한사람만 보기 -->

<table style="width: 90%">
  <tr style="background-color: silver;">
    <th>주문상품</th><th>가격(소계)</th><th>주문수량</th><th>조회</th>
  </tr>
  <%
  	int totalPrice = 0;
    Hashtable hCart = cartMgr.getCartList();	//cart에 저장된 전체 자료 읽기
    if(hCart.size() == 0){
  %>
  <tr><td colspan="4">주문 건수가 없습니다</td></tr>
  <%
  	}else{
  	  Enumeration enu = hCart.keys();
  	  while(enu.hasMoreElements()){
  		  OrderBean order = (OrderBean)hCart.get(enu.nextElement());
  		  ProductDto product = productMgr.getProduct(order.getProduct_no());
  		  int price = Integer.parseInt(product.getPrice());
  		  int quantity = Integer.parseInt(order.getQuantity());
  		  int subTotal = price * quantity;	//소계
  		  totalPrice += subTotal;	//총계
  		  //System.out.println(product.getName() + " " + price + " " + quantity + " " + subTotal);
  %>
  <tr style="text-align: center;">
    <td><%=product.getName() %></td>
    <td><%=subTotal %></td>
    <td><%=quantity %></td>
    <td>
    	<a href="javascript:productDetail_guest('<%=product.getNo() %>')">상세보기</a>
    </td>
  </tr>
  <% } %>
  <tr>
    <td colspan="4">
    	<br>
    	총 결제 금액 : <%=totalPrice %> &nbsp;&nbsp;
    	<a href="orderproc.jsp">[ 주문하기 ]</a>
    </td>
  </tr>
  <%
  }
  %>
</table>
  
<%@ include file="guest_bottom.jsp" %>

<form action="productdetail_g.jsp" name="detailFrm">
	<input type="hidden" name="no">
</form>
</body>
</html>