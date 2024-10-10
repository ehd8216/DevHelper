<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .commitList{
    min-height: 900px;
    width: 80%;
    margin: auto;
  }

</style>
</head>
<body>
  <jsp:include page="../common/menubar.jsp" />
  
  <div class="outer">
    <div class="commitList">
    	<c:forEach var="c" items="${ commitList }">
    		<div>${ c.comAuthor }</div>
    		<div>${ c.comMessage }</div>
    		<div>${ c.comDate }</div>
    		<div>${ c.SHA }</div>
    		<br>
    	</c:forEach>
      


    </div>

  </div>
</body>
</html>