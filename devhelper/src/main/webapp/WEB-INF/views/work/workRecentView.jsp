<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>workRecentView</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
body {
    height: 1500px;
}

.title {
    font-size: 40px;
    font-weight: bold;
    padding-top: 80px;
    padding-bottom: 40px;
}

.workInfo {
    padding: 30px;
    margin-top: 20px;
    text-align: center;
}

.list-area {
    table-layout: fixed;
    width: 1300px;
    margin: 0 auto;
}

.list-area td {
    overflow: hidden; 
    text-overflow: ellipsis;
    white-space: nowrap; 
    max-width: 150px;
}

thead {
    background-color: antiquewhite;
    height: 60px;
}

tbody td {
    text-align: center;
    vertical-align: middle;
    font-size: 18px;
    height: 45px;
}

thead th {
    vertical-align: middle;
    font-size: 20px;
}

tbody tr {
    border-top: 1px solid lightgray;
}

tbody tr:hover {
    cursor: pointer;
    background-color: rgb(250, 246, 240);
}

.favorite:hover {
    color: red;
}

#back-to-top {
    position: fixed;
    bottom: 40px;
    right: 40px;
    font-size: 18px;
    padding: 10px 20px;
    background-color: #000;
    color: #fff;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}

#back-to-top:hover {
    background-color: #555;
}

#page-numbers button {
    margin: 5px;
    padding: 5px 10px;
    font-size: 16px;
}

#page-numbers .active {
    background-color: #000;
    color: #fff;
}
  </style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp" />

    <div class="title" align="center">최근본 공고</div>

    <div class="workInfo" align="center">
        <table class="list-area" id="result1">
            <thead>
                <tr>
                    <th width="160px">공시기관</th>
                    <th>제목</th>
                    <th width="160px">마감일</th>
                    <th width="180px">채용분야</th>
                    <th width="150px">고용형태</th>
                    <th width="150px">채용구분</th>
                    <th width="75px">근무지</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
        <script>
        // 쿠키에서 최근 본 공고를 가져오는 함수
        function getCookie(name) {
            const value = `; ${document.cookie}`;
            const parts = value.split(`; ${name}=`);
            if (parts.length === 2) return parts.pop().split(';').shift();
        }

        function loadRecentJobs() {
            const recentJobs = JSON.parse(getCookie('recentJobs') || '[]');
            if (recentJobs.length === 0) {
                // 최근 본 공고가 없을 경우
                $("#result1 tbody").html("<tr><td colspan='7' align='center'>최근 본 공고가 없습니다.</td></tr>");
                return;
            }

            // 최근 본 공고를 API로 가져오는 부분
            $.ajax({
                url: "https://apis.data.go.kr/1051000/recruitment/list", // 실제 API URL로 변경
                method: "POST",
                data: { snList: recentJobs }, // 최근 본 공고 목록 전달
                success: function(data) {
                    let html = "";
                    // data는 최근 본 공고의 배열이라고 가정
                    $.each(data, function(index, job) {
                        html += "<tr>";
                        html += "<td>" + job.instNm + "</td>";
                        html += "<td>" + job.recrutPbancTtl + "</td>";
                        html += "<td>" + job.pbancEndYmd + "</td>";
                        html += "<td>" + job.ncsCdNmLst + "</td>";
                        html += "<td>" + job.hireTypeNmLst + "</td>";
                        html += "<td>" + job.recrutSeNm + "</td>";
                        html += "<td>" + job.workRgnNmLst + "</td>";
                        html += "</tr>";
                    });
                    $("#result1 tbody").html(html);
                },
                error: function() {
                    console.log("최근 본 공고를 불러오는 중 오류 발생");
                }
            });
        }

        // 페이지가 로드될 때 최근 본 공고를 불러옴
        $(document).ready(function() {
            loadRecentJobs();
        });
    </script>
</body>
</html>