<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Issues List</title>
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
                    <th>작성자</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty issues}">
                    <c:forEach var="i" items="${issues}">
                        <tr>
                            <td>${i.getNumber()}</td>
                            <td>${i.getTitle()}</td>
                            <td>${i.getUser().login}</td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty issues}">
                    <tr>
                        <td colspan="2">이슈가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
