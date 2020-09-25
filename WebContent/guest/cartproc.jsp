<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="kr.shop.order.CartMgr" scope="session" />
<!-- scope="session" => 로그인한 사람한테만 해당되는 페이지 -->
<jsp:useBean id="order" class="kr.shop.order.OrderBean" />
<jsp:setProperty property="*" name="order" />

<%
//컨트롤러 역할 : flag - 구매목록 보기, 수정, 삭제 판단
String flag = request.getParameter("flag");
String id = (String)session.getAttribute("idKey");	//session으로 id읽음
//out.println(order.getProduct_no() + " 주문수 : " + order.getQuantity());

if(id == null){	//로그인 안하고 온 경우
	response.sendRedirect("../member/login.jsp"); 
}else{
	if(flag == null){	//flag = null 이면 => 구매목록 보기 - 카트에 담기
		order.setId(id);
		cartMgr.addCart(order);	//id, product_no, quantity를 들고 addcart 호출
%>
		<script>
		alert("장바구니에 상품 담기 성공!");
		location.href="cartlist.jsp";	//장바구니에 담은 내용 확인 페이지로 이동
		</script>
<%
	}else if(flag.equals("update")){	//장바구니 수정
		order.setId(id);
		cartMgr.updateCart(order);
%>
		<script>
		alert("장바구니 내용 수정 성공!");
		location.href="cartlist.jsp";	//장바구니에 담은 내용 확인 페이지로 이동
		</script>
<%		
	}else if(flag.equals("del")){		//장바구니에서 상품 삭제
		cartMgr.deleteCart(order);
%>
		<script>
		alert("장바구니에 담은 상품 삭제 성공!");
		location.href="cartlist.jsp";	//장바구니에 담은 내용 확인 페이지로 이동
		</script>
<%			
	}
}
%>