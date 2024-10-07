<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	#boardList {
            text-align: center;
        }
        
        #boardList>tbody>tr:hover {
            cursor: pointer;
        }
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
    <div class="outer">
	 <table id="boardList" class="table table-hover" align="center">
                <thead>
                  <tr>
                    <th>번호</th>
                    <th>issues Title</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="i" items="${issues}">
	                    <tr>
	                        <td>i.getNumber()</td>
	                        <td>i.getTitle</td>               
	                    </tr>                
                </c:forEach>
                </tbody>
            </table>
    </div>
</body>