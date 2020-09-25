<%@page import="kr.shop.board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />    
<jsp:useBean id="dto" class="kr.shop.board.BoardDto" />

<%
String num = request.getParameter("num");
String spage = request.getParameter("page");
dto = boardMgr.getData(num);	//수정 대상 자료 읽기
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script type="text/javascript">
function check(){
	if(frm.pass.value == ""){
		frm.pass.focus();
		alert("비밀번호를 입력하세요");
		return;
	}
	if(confirm("정말 수정할까요?")){
		frm.submit();
	}
}
</script>
</head>
<body>
<h2 style="text-align: center;">** 글 수정 **</h2>
<form action="editsave.jsp" name="frm" method="post">
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="page" value="<%=spage %>">
<table border="1">
  <tr>
  	<td>이름</td>
  	<td>
  		<input type="text" name="name" value="<%=dto.getName() %>">
  	</td>
  </tr>
  <tr>
  	<td>암호</td>
  	<td><input type="text" name="pass"></td>	<!-- password는 value 주지않음 -->
  </tr>
  <tr>
  	<td>메일</td>
  	<td>
  		<input type="text" name="mail" value="<%=dto.getMail() %>">
  	</td>
  </tr>
   <tr>
  	<td>제목</td>
  	<td>
  		<input type="text" name="title" value="<%=dto.getTitle() %>">
  	</td>
  </tr>
  <tr>
  	<td>내용</td>
  	<td>
  		<textarea rows="10" style="width: 97%" name="cont"><%=dto.getCont() %></textarea>
  	</td>
  </tr>
  <tr>
    <td colspan="2" style="text-align: center;">
    	<input type="button" value="수정완료" onclick="check()">&nbsp;
    	<input type="button" value="목록보기" 
    		onclick="location.href='boardlist.jsp?page=<%=spage%>'">	<!-- 원래 페이지로 돌아가기 -->
    </td>
  </tr>
</table>
</form>
</body>
</html>