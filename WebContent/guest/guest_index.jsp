<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="topmargin:20;">
<table style="width: 90%">
  <tr>
    <td style="font-size: 20px;">전문 쇼핑몰</td>
  </tr>
</table>

<%@ include file="guest_top.jsp" %>
<table style="width: 90%">
<% if(memid != null){ %>
	<tr>
		<td>
			<%=memid %>님! 방문을 환영합니다.
			<img title="hi" src="../images/pic2.gif">
		</td>
	</tr>
<%}else{ %>
	<tr style="text-align: center;">
		<td style="font-size: 20px; background-image: url(../images/pic.jpg); background-size: 100%">
			<br><br><br><br><br><br>고객님 어서오세요
			<br><br><br>로그인 후 이용바랍니다
			<br><br>
		</td>
	</tr>
<%} %>
</table>

<%@ include file="guest_bottom.jsp" %>

</body>
</html>