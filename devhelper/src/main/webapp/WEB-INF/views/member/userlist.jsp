<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <style>
/* userlist.css */

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
}

.userlist-container {
    width: 60%;  /* 가로 길이를 줄였습니다 */
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
    color: #333;
}

.userlist-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: white;  /* 테이블 배경색을 흰색으로 변경 */
}

.userlist-table th, .userlist-table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.userlist-table th {
    background-color: #835900;
    color: white;
    text-transform: uppercase;
}

.userlist-table tr:hover {
    background-color: #f1f1f1;
}

.userlist-table td {
    color: #555;
}

/* td 내의 버튼을 가운데 정렬 */
.userlist-table td button{
    text-align: center;
    vertical-align: middle;
}

/* 친구신청 버튼 스타일 */
.friend_btn {
    background-color: #ffedba;
    color: rgb(0, 0, 0);
    border: none;
    padding: 8px 16px;
    border-radius: 20px;  /* 둥근 모서리 */
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease; /* 부드러운 전환 효과 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);  /* 가벼운 그림자 */
}

.friend_btn:hover {
    background-color: #ffedba;
    box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);  /* hover 시 그림자 강화 */
}

.friend_btn:active {
    background-color: #ffedba;
    transform: translateY(2px);  /* 클릭 시 버튼이 약간 눌리는 효과 */
}


    </style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp" />
    
    <div class="userlist-container">
        <h1>User List</h1>
        <table class="userlist-table">
            <thead>
                <tr>
                    <th>닉네임</th>
                    <th>자시소개</th>
                    <th>기술 스택</th>
                    <th>친구</th>
                </tr>
            </thead>
            <tbody>
           <c:forEach var="l" items="${list}">
                    <c:if test="${loginMember.memNo != l.memNo}">
                        <tr>
                            <td>${l.gitNick}</td>
                            <td>${l.memIntro}</td>
                            <td>${l.stackName}</td>
                            <td><button class="friend_btn" onclick="sendFriend(${l.memNo})">친구신청</button></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>
 <script>
        function sendFriend(memNo) {
            $.ajax({
                url: "friend.me",
                data: { memNo: memNo },
                success: function(result) {
                    if (result === 1)
                    {
                        alert("친구 신청이 성공했습니다.");
                    } 
                    else if(result ===2)
                   	{
                   		alert("이미 요청된 유저입니다.")
                   	}
                    else 
                    {
                        alert("친구 신청에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    alert("오류가 발생했습니다: " + error);
                }
            });
        }
    </script>
</body>
</html>
