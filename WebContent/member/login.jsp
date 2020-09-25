<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("idKey"); //세션 읽기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 로그인</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnLogin").addEventListener("click", funcLogin, false);
	//document.getElementById("btnNewMember").addEventListener("click", funcNew, false);
	document.getElementById("btnHome").addEventListener("click", funcHome, false);
}

function funcLogin(){
	//alert("a");
	if(loginForm.id.value === ""){
		alert("id 입력");
		loginForm.id.focus();
	}else if(loginForm.passwd.value === ""){
		alert("passwd 입력");
		loginForm.passwd.focus();
	}else{		//id, passwd 모두 제대로 입력했다면 loginproc.jsp로
		loginForm.action = "loginproc.jsp";
		loginForm.method = "post";
		loginForm.submit();
	}
}

function funcNew(){
	location.href="register.jsp";
}

function funcHome(){
	location.href="../guest/guest_index.jsp";	//guest.jsp로 불러도 된다
}
</script>
</head>
<body>
<br>

<% //if문 전체(47~55줄 + 80줄) 주석 처리. form tag만 살림
//if(id != null){	//id가 있으면
%>
<%-- 
	<b><%=id %>님 환영합니다</b>
	준비된 기능을 사용할 수 있어요<br>
	<a href="logout.jsp">로그아웃</a>
--%>
<%// }else{%>		<!-- id가 없으면 -->

	<form name="loginForm">
	<table>
	  <tr>
	  	<td>** 로그인 **</td>
	  </tr>
	  <tr>
	  	<td>아이디 : <input type="text" name="id"></td>
	  </tr>
	  <tr>
	  	<td>비밀번호 : <input type="text" name="passwd"></td>
	  </tr>
	  <tr>
	  	<td>
	  		<input type="button" value="로 그 인" id="btnLogin">&nbsp;
	  		<!-- 
	  		<input type="button" value="회원가입" id="btnNewMember">
	  		-->
	  		<input type="button" value="홈페이지" id="btnHome"> 
	  	</td>
	  </tr>
	</table>
	</form>
<%	
// }
%>
</body>
</html>