<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />
<jsp:useBean id="dto" class="kr.shop.board.BoardDto" />
    
<%
String num = request.getParameter("num");
String spage = request.getParameter("page");
//out.print(num + " " + spage); 

boardMgr.updateReadcnt(num);	//조회수 증가
dto = boardMgr.getData(num);	//'상세보기' 레코드 얻기
//out.println(dto.getName());

String name = dto.getName();
String pass = dto.getPass();
String mail = dto.getMail();
String title = dto.getTitle();
String cont = dto.getCont();
String bip = dto.getBip();
String bdate = dto.getBdate();
int cnt = dto.getReadcnt();

String apass = "*****";	//일반인에게는 비밀번호 숨김
String adminOk = (String)session.getAttribute("adminOk");	//session:내장객체
if(adminOk != null) {
	if(adminOk.equalsIgnoreCase("admin")) apass = pass;	//관리자로 로그인 시 비밀번호 보임
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
</head>
<body>
<table>
	<tr>
		<td><b>비밀번호:<%=apass %></b></td>
		<td colspan="2" style="text-align: right;">
			<a href="reply.jsp?num=<%=num %>&page=<%=spage %>">
				<img src="../images/reply.gif">
			</a>
			<a href="edit.jsp?num=<%=num %>&page=<%=spage %>">
				<img src="../images/edit.gif">
			</a>
			<a href="delete.jsp?num=<%=num %>&page=<%=spage %>">
				<img src="../images/del.gif">
			</a>
			<a href="boardlist.jsp?page=<%=spage %>">
				<img src="../images/list.gif">
			</a>
		</td>
	</tr>
	<tr>
		<td>
		작성자 : <a href="mailto:<%=mail %>"><%=name %></a> (ip : <%=bip %>)
		</td>
		<td>작성일 : <%=bdate %></td>
		<td>조회수 : <%=cnt %></td>
	</tr>
	<tr>
		<td colspan="3" style="background-color: cyan">제목 : <%=title %></td>
	</tr>
	<tr>
		<td colspan="3">
			<textarea rows="10" style="width: 99%" readonly="readonly"><%=cont %></textarea>
		</td>
	</tr>	
</table>

</body>
</html>











