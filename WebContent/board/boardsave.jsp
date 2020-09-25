<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />
<jsp:useBean id="bean" class="kr.shop.board.BoardBean" />
<jsp:setProperty property="*" name="bean" />

<%
bean.setBip(request.getRemoteAddr());
bean.setBdate();
int maxNum = boardMgr.currentGetNum() + 1;
bean.setNum(maxNum);
bean.setGnum(maxNum);
boardMgr.saveData(bean);

response.sendRedirect("boardlist.jsp?page=1");	//저장 후 목록보기


%>