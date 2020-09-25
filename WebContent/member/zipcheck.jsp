<!-- 우편번호 찾기 -->
<%@page import="kr.shop.member.ZipcodeDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberMgr" class="kr.shop.member.MemberMgr" scope="page" />

<%
request.setCharacterEncoding("utf-8");
String check = request.getParameter("check");	//한 번 불리고나서부터 check은 n이 되어있음
String p_area3 = request.getParameter("area3");	//검색 동이름

ArrayList<ZipcodeDto> list = memberMgr.zipcodeRead(p_area3);//동이름 처음에는 X => 다음부터는 입력값
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnZipFind").onclick = dongCheck;

	document.getElementById("btnZipClose").onclick = function(){
		window.close();
	};
}

function dongCheck(){
	//alert("c");
	if(zipForm.area3.value === ""){
		alert("검색할 동이름을 입력하시오");
		zipForm.area3.focus();
		return;
	}
	
	zipForm.submit();
}

function send(zipcode, area1, area2, area3, area4){	//동 검색해서 밑에 나온 주소들 중 선택한 주소의 우편번호 받아오기
	//alert(zipcode + " " + area1);
	opener.document.regForm.zipcode.value = zipcode;
	var addr = area1 + " " + area2 + " " + area3 + " " + area4;
	opener.document.regForm.address.value = addr;
	window.close();
}

</script>
</head>
<body>
<b>** 우편번호 찾기 **</b><br>
<form action="zipcheck.jsp" name="zipForm" method="post">
<table>
  <tr>
    <td>
         동 이름 입력 : <input type="text" name="area3">
    <input type="button" value="검색" id="btnZipFind">
    <input type="button" value="닫기" id="btnZipClose">
    <input type="hidden" value="n" name="check">
    </td>
  </tr>
</table>
</form>

<%
if(check.equals("n")){
	if(list.isEmpty()){
%>
		<b>검색 결과가 없습니다!</b>
<%
	}else{
%>
	<table>
	  <tr>
	    <td style="text-align: center;color: red">	    
	 	   검색자료를 클릭하면 자동으로 주소가 입력됩니다 
	    </td>
	  </tr>
	  <tr>
	    <td>
<%
		for(int i=0; i < list.size(); i++){
			ZipcodeDto dto = list.get(i);
			String zipcode = dto.getZipcode();
			String area1 = dto.getArea1();
			String area2 = dto.getArea2();
			String area3 = dto.getArea3();
			String area4 = dto.getArea4();
			if(area4 == null) area4 = "";	//area4(기타)에 값이 없는 경우 공백처리
%>
		<a href="javascript:send('<%=zipcode %>','<%=area1 %>','<%=area2 %>','<%=area3 %>','<%=area4 %>')">
		<%=zipcode %> <%=area1 %> <%=area2 %> <%=area3 %> <%=area4 %>
		</a><!-- a tag로 감싼 부분 전부 hypertext : 동이름으로 검색한 주소들 -->
		<br>
<%
		}
%>	    	
	    </td>
	  </tr>
	</table>
<%
	}
}
%>
</body>
</html>