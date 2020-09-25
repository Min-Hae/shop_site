<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자:상품추가</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="margin-up: 20px">
<%@include file="admin_top.jsp" %>	<!-- admin으로 로그인했을 경우에만 상품관리 가능 -->

<form action="productproc.jsp?flag=insert" enctype="multipart/form-data" method="post">
<table style="width: 90%">
  <tr>
    <th colspan="2">** 상품 등록 **</th><!-- 아래 순서 : db에 있는 순서 -->
  </tr>
  <tr>
    <td>상품명</td>
    <td><input type="text" name="name"></td>
  </tr>
  <tr>
    <td>가 격</td>
    <td><input type="text" name="price"></td>
  </tr>
  <tr>
    <td>설 명</td>
    <td><textarea rows="5" cols="60" name="detail"></textarea></td>
  </tr>
  <tr>
    <td>재고량</td>
    <td><input type="text" name="stock"></td>
  </tr>
  <tr>
    <td>이미지</td>
    <td><input type="file" name="image" size="40"></td>	<!-- 이미지가 file형태로 넘어가기 때문에 위에서 enctype="multipart"이용 -->
  </tr>
  <tr>
    <td colspan="2" style="text-align: center;">
    	<br><br>
    	<input type="submit" value="상품 등록">
    	<input type="reset" value="새로 입력">
    </td>
  </tr>
</table>
</form>

<%@include file="admin_bottom.jsp" %>
</body>
</html>