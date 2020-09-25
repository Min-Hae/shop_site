<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />
    
    
<%
request.setCharacterEncoding("utf-8");

String spage = request.getParameter("page");
String num = request.getParameter("num");
String pass = request.getParameter("pass");

boolean b = boardMgr.checkPass(Integer.parseInt(num), pass);	// bean.getPass : 클라이언트가 수정할때 넣은 비밀번호

if(b){	//수정 시 입력한 비밀번호가 일치했으면
	boardMgr.delData(num);
	response.sendRedirect("boardlist.jsp?page=" + spage);	//글 삭제 후 목록보기
}else{	//수정 시 입력한 비밀번호가 일치하지 않았으면
%>
	<script>
	alert("비밀번호 불일치!!!");
	history.back();
	</script>
<%	
}
%>
    