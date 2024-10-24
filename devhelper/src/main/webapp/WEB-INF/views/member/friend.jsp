<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>친구 요청 관리</title>
   <style>
    /* 기본 스타일 */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f9f9f9;
    }

    .userlist-container {
        background-color: #ffffff;
        border-radius: 8px;
        width:70%;
        margin:auto;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
        font-size: 24px;
        margin-bottom: 20px;
    }

    /* 탭 스타일 */
    .tabs {
        display: flex;
        cursor: pointer;
        margin-bottom: 20px;
    }

    .tab {
        padding: 10px 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-right: 5px;
        background-color: #e7e7e7;
        transition: background-color 0.3s;
    }

    .tab.active {
        background-color: #007bff;
        color: white;
    }

    /* 요청 목록 스타일 */
    .request-list {
        display: none; /* 기본적으로 숨김 */
    }

    .request-list.active {
        display: block; /* 'block'으로 변경하여 div가 올바르게 표시되도록 함 */
        margin-top: 20px; /* 요청 목록 간격 조정 */
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px; /* 테이블과 제목 간격 */
        margin-bottom: 20px; /* 테이블 하단 여백 추가 */
    }

    th, td {
        border: 1px solid #ccc;
        padding: 12px; /* 셀 패딩 조정 */
        text-align: center;
        height: 30px;
       	vertical-align:middle !important;
    }

    th {
        background-color: #f1f1f1;
    }

    /* 버튼 스타일 */
    .friend_btn_y {
        padding: 5px 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
     .friend_btn_n {
        padding: 5px 10px;
        background-color: #fa8080;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .friend_btn_y:hover {
        background-color: #0056b3;
    }
     .friend_btn_n:hover {
        background-color: #fd3939;
    }
</style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 추가 -->
</head>
<body>
    <jsp:include page="../common/menubar.jsp" />
	 <c:if test="${not empty message}">
        <script>
            alert('${message}');
        </script>
    </c:if>
    <div class="userlist-container">
        <h1>친구 요청 관리</h1>
        
        <div class="tabs">
            <div class="tab active" onclick="showRequests('received')">받은 요청</div>
            <div class="tab" onclick="showRequests('sent')">보낸 요청</div>
            <div class="tab" onclick="showRequests('friends')">친구 목록</div>
        </div>

        <div id="receivedRequests" class="request-list active">
            <h2>받은 친구 요청</h2>
 				 <table>
                <thead>
                    <tr>
                        <th style="width: 80%">닉네임</th>
                        <th style="width: 10%"></th>
                        <th style="width: 10%"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty receivedRequests}">
                        <tr>
                            <td colspan="2">받은 친구 요청이 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="request" items="${receivedRequests}">
                        <tr>
                            <td>${request.GITNICK}</td>
                            <td><button class="friend_btn_y" onclick="friendYes(${request.MEMNO});">수락</button></td>
                            <td><button class="friend_btn_n" onclick="friendNo(${request.MEMNO});">거절</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="sentRequests" class="request-list">
            <h2>보낸 친구 요청</h2>
              <table>
                <thead>
                    <tr>
                        <th>닉네임</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${sentRequests == null || empty sentRequests}">
					    <tr>
					        <td colspan="2">보낸 친구 요청이 없습니다.</td>
					    </tr>
					</c:if>
                   		<c:forEach var="request" items="${sentRequests}">
						    <tr>
						        <td>${request.GITNICK}</td>
						        <td>
						            <c:choose>
						                <c:when test="${request.STATUS.equals('A')}">대기중</c:when>
						                <c:when test="${request.STATUS.equals('B')}">거절함</c:when>
						                <c:otherwise>알 수 없음</c:otherwise>
						            </c:choose>
						        </td>
						    </tr>
						</c:forEach>
                </tbody>
            </table>
        </div>

        <div id="friendsList" class="request-list"> <!-- ID를 friendsList로 변경 -->
            <h2>친구 목록</h2>
            <table>
                <thead>
                    <tr>
                        <th>닉네임</th>
                        <th>자기소개</th>
                        <th>기술 스택</th>
                    </tr>
                </thead>
                 <tbody id="friendListBody">
		            <!-- 친구 목록이 여기에 동적으로 추가됩니다 -->
		         </tbody>
            </table>
        </div>
    </div>

    <script>
    function loadFriendList() {
        $.ajax({
            url: "friendlist.me", // 서버에 보낼 URL
            type: "GET", // HTTP 메서드 타입
            data: {
                memNo: "${loginMember.memNo}" // 로그인한 회원의 memNo를 전달
            },
            success: function(data)
            {
                // AJAX 호출이 성공하면 데이터를 파싱하여 테이블에 추가
                let friendListBody = $("#friendListBody");
                friendListBody.empty(); // 기존 목록 비우기

                // data는 서버에서 받아온 친구 목록으로 가정 (Array 형태)
                $.each(data, function(index, friend)
                {
                    let row = "<tr>" +
                                "<td>" + friend.gitNick + "</td>" +
                                "<td>" + friend.memIntro + "</td>" +
                                "<td>" + friend.stackName + "</td>" +
                              "</tr>";
                    friendListBody.append(row); // 테이블에 한 줄씩 추가
                });
            },
            error: function()
            {
                console.log("실패!!!!!!");
            }
        });
    }

    // 페이지 로드 시 친구 목록 불러오기
    $(document).ready(function() {
        loadFriendList();
    });
        function showRequests(type) {
            // 모든 요청 목록 숨기기
            $('.request-list').removeClass('active');
            
            // 선택한 요청 목록 표시
            $('#' + (type === 'friends' ? 'friendsList' : type + 'Requests')).addClass('active');
            
            // 모든 탭 비활성화
            $('.tab').removeClass('active');
            
            // 현재 선택한 탭 활성화
            if (type === 'received') {
                $('.tab').eq(0).addClass('active');
            } else if (type === 'sent') {
                $('.tab').eq(1).addClass('active');
            } else if (type === 'friends') {
                $('.tab').eq(2).addClass('active');
            }
        }

        function friendYes(memNo) {
            // 수락 요청
            location.href = "receive.me?memNo=" + memNo + "&action=Y"; // Y값을 쿼리 파라미터로 추가
        }

        function friendNo(memNo) {
            // 거절 요청
            location.href = "receive.me?memNo=" + memNo + "&action=B"; // N값을 쿼리 파라미터로 추가
        }
    </script>
</body>
</html>