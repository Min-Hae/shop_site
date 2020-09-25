<%@page import="kr.shop.product.ProductDto"%>
<%@page import="kr.shop.order.OrderDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="orderMgr" class="kr.shop.order.OrderMgr" />
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문정보</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="margin-top: 20px;">
** 주문 상품 목록 **<p/>
<%@ include file="guest_top.jsp" %>

<table style="width: 90%"> 
  <tr><th>주문번호</th><th>상품명</th><th>주문 수</th><th>주문일</th><th>주문상태</th></tr>
  <%
  	String id = (String)session.getAttribute("idKey");
    ArrayList<OrderDto> list = orderMgr.getOrder(id);
    if(list.size() == 0){	//db에 저장안된 경우(주문한 상품이 없는 경우)
  %>
  <tr>
    <td colspan="5">주문한 상품이 없습니다</td>
  </tr>
  <%
  	}else{	//주문한 상품이 있는 경우
  	  for(OrderDto ord:list){
  		  ProductDto product = productMgr.getProduct(ord.getProduct_no());
  %>
  <tr style="text-align: center;">
    <td><%=ord.getNo() %></td>
    <td><%=product.getName() %></td>
	<td><%=ord.getQuantity() %></td>
	<td><%=ord.getSdate() %></td>
	<td>
	<%
		switch(ord.getState()){
		case "1":out.println("접수"); break;
		case "2":out.println("입금확인"); break;
		case "3":out.println("배송준비"); break;
		case "4":out.println("배송중"); break;
		case "5":out.println("처리완료"); break;
		default:out.println("접수중");
		}
	%>
	</td>
  </tr>
  <%
	  }
  }
  %>
</table>

<%@ include file="guest_bottom.jsp" %>
</body>
</html>