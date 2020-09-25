<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="bean" class="kr.shop.board.BoardBean" />
<jsp:setProperty property="*" name="bean" />
<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />

<%
//out.println(bean.getName());
String spage = request.getParameter("page");

boolean b = boardMgr.checkPass(bean.getNum(), bean.getPass());	// bean.getPass : 클라이언트가 수정할때 넣은 비밀번호
if(b){	//수정 시 입력한 비밀번호가 일치했으면
	boardMgr.saveEdit(bean);
	response.sendRedirect("boardlist.jsp?page=" + spage);	//글 수정 후 목록보기
}else{	//수정 시 입력한 비밀번호가 일치하지 않았으면
%>
	<script>
	alert("비밀번호 불일치!!!");
	history.back();
	</script>
<%	
}
%>

