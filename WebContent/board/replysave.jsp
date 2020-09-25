<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bean" class="kr.shop.board.BoardBean" />
<jsp:setProperty property="*" name="bean" />
<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />

<%
String spage = request.getParameter("page");

int num = bean.getNum();
int gnum = bean.getGnum();
int onum = bean.getOnum() + 1;	//원글에 대한 댓글이므로 오더넘버 1증가
int nested = bean.getNested() + 1;

// 같은 그룹 내에서 새로운 댓글의 onum보다 크거나 같은 값을 댓글 입력 전에 먼저 수정하기. 작으면 수정안함.
boardMgr.updateOnum(gnum, onum);	//onum 갱신하기 위함

// 댓글 자료 저장
bean.setOnum(onum);
bean.setNested(nested);
bean.setBip(request.getRemoteAddr());
bean.setBdate();
bean.setNum(boardMgr.currentGetNum() + 1);	//댓글(새글)의 레코드 번호

boardMgr.saveReplyData(bean);
response.sendRedirect("boardlist.jsp?page=" + spage);	//댓글 저장 후 목록보기
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>