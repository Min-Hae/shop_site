<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="kr.shop.order.OrderMgr" />

<%
String no = request.getParameter("no");
String flag = request.getParameter("flag");
String state = request.getParameter("state");
//out.print(no + " " + flag + " " + state);

boolean b = false;

if(flag.equals("update")){
	b = orderMgr.updateOrder(no, state);
}else if(flag.equals("delete")){
	b = orderMgr.deleteOrder(no);
}else{
	response.sendRedirect("ordermanager.jsp");
}

if(b){
%>
	<script>
	alert("정상처리되었습니다");
	location.href="ordermanager.jsp";
	</script>
<% }else{ %>
	<script>
	alert("오류발생\n관리자에게 문의 바람");
	location.href="ordermanager.jsp";
	</script>
<%
}
%>
