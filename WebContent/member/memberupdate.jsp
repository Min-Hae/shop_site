<%@page import="kr.shop.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memberMgr" class="kr.shop.member.MemberMgr" />

<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");	//세션을 읽음

MemberDto dto = memberMgr.getMember(id); 

if(dto == null){
	response.sendRedirect("../guest/guest_index.jsp");
	return;  //service 메소드를 탈출
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnUpdate").onclick=memberUpdate;
	document.getElementById("btnUpdateCancel").onclick=memberUpdateCancel;
	document.getElementById("btnDelete").onclick=memberDelete;
}
</script>
</head>
<body>
<form action="memberupdateproc.jsp" name="updateForm" method="post">
<table>
  <tr style="background-color: navy;">
  	<td colspan="2" style="color: white">
  		<b><%=dto.getName() %></b> 회원님의 정보를 수정합니다 
  	</td>
  </tr>
  <tr>
  	<td>아이디</td>
  	<td><%=dto.getId() %></td>
  </tr>
  <tr>
  	<td>비밀번호</td>
  	<td>
  		<input type="password" name="passwd" 
  			value="<%=dto.getPasswd()%>">
  	</td>
  </tr>
  <tr>
  	<td>회원명</td>
  	<td>
  		<input type="text" name="name" value="<%=dto.getName()%>">
  	</td>
  </tr>
  <tr>
  	<td>이메일</td>
  	<td>
  		<input type="text" name="email" value="<%=dto.getEmail()%>">
  	</td>
  </tr>
  <tr>
  	<td>전화번호</td>
  	<td>
  		<input type="text" name="phone" value="<%=dto.getPhone()%>">
  	</td>
  </tr>
  <tr>
  	<td>우편번호</td>
  	<td>
  		<input type="text" name="zipcode" value="<%=dto.getZipcode()%>">
  	</td>
  </tr>
  <tr>
  	<td>주소</td>
  	<td>
  		<input type="text" name="address" 
  			value="<%=dto.getAddress()%>" size="50">
  	</td>
  </tr>
  <tr>
  	<td>직업</td>
  	<td>
  		<select name="job">
  			<option value="<%=dto.getJob()%>"><%=dto.getJob()%></option>
  			<option value="회사원">회사원</option>
  			<option value="학생">학생</option>
  			<option value="자영업">자영업</option>
  			<option value="기타">기타</option>
  		</select>

  	</td>
  </tr>
  <tr>
  	<td colspan="2" style="text-align: center;">
  		<input type="button" value="수정완료" id="btnUpdate">
  		<input type="button" value="수정취소" id="btnUpdateCancel">
  		<input type="button" value="회원탈퇴" id="btnDelete">
  	</td>
  </tr>
</table>
</form>
</body>
</html>





