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

        /* 모달 스타일 */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: white;
            margin: 15% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
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
                    <th>Issues Title</th>
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
                        <td colspan="3">이슈가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 이슈 작성 버튼 -->
    <button id="openModalBtn">이슈 작성하기</button>

    <!-- 이슈 작성 모달 -->
    <div id="issueModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form id="issueForm" action="issuesInsert.re" method="post">
            	<input id="writer" type="hidden" value="${writer}" name="writer">
            	<input id="repoName" type="hidden" value="${repoName}" name="repoName">
                <label for="title">이슈 제목:</label>
                <input type="text" id="title" name="title" required><br><br>
                
                <label for="body">이슈 내용:</label>
                <textarea id="body" name="body" required></textarea><br><br>

                <button type="submit">이슈 생성</button>
            </form>
        </div>
    </div>

    <script>
        // 모달 열기
        $("#openModalBtn").click(function(){
            $("#issueModal").show();
        });

        // 모달 닫기
        $(".close").click(function(){
            $("#issueModal").hide();
        });

        // 모달 외부 클릭 시 닫기
        $(window).click(function(event) {
            if (event.target == $("#issueModal")[0]) {
                $("#issueModal").hide();
            }
        });
        $(function()
        {
        	$("#boardList tbody tr").click(function()
        	{
        		var issueNum = $(this).children('td').first().text();
        		var writer = $("#writer").val();
        		var repoName = $("#repoName").val();
        		console.log(writer,repoName)
        		location.href = "issuesDetail.re?issueNum=" + issueNum + "&writer=" + writer + "&repoName=" + repoName;
        	})
        })
    </script>
</body>
</html>
