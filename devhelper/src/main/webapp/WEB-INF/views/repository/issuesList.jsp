<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Issues List</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 중앙 정렬을 위한 스타일 */
        .outer {
            padding: 30px;
            margin: 0 auto;
            width: 80%;
        }

        #boardList {
            width: 100%;
            margin-top: 20px;
        }

        #boardList>tbody>tr:hover {
            background-color: #f2f2f2;
            cursor: pointer;
        }

        /* 테이블 스타일 */
        table, th, td {
            border: 1px solid #dee2e6;
        }

        th {
            background-color: #343a40;
            color: rgb(0, 0, 0);
            text-align: center;
        }

        td {
            text-align: center;
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
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            border: none;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 40%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        /* 버튼 스타일 */
        #openModalBtn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        #openModalBtn:hover {
            background-color: #0056b3;
        }

        /* 이슈 작성 폼 스타일 */
        form label {
            font-weight: bold;
        }

        form input, form textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp" />
    <div class="outer">
        <h2 class="text-center">Issues List</h2>
        <table id="boardList" class="table table-hover">
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
    <div class="text-center">
        <button id="openModalBtn" class="btn btn-primary">이슈 작성하기</button>
    </div>

    <!-- 이슈 작성 모달 -->
    <div id="issueModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form id="issueForm" action="issuesInsert.re" method="post">
                <input id="writer" type="hidden" value="${writer}" name="writer">
                <input id="repoName" type="hidden" value="${repoName}" name="repoName">

                <label for="title">이슈 제목:</label>
                <input type="text" id="title" name="title" required>

                <label for="body">이슈 내용:</label>
                <textarea id="body" name="body" required></textarea>

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

        $(function() {
            $("#boardList tbody tr").click(function() {
                var issueNum = $(this).children('td').first().text();
                var writer = $("#writer").val();
                var repoName = $("#repoName").val();
                location.href = "issuesDetail.re?issueNum=" + issueNum + "&writer=" + writer + "&repoName=" + repoName;
            });
        });
    </script>
</body>
</html>
