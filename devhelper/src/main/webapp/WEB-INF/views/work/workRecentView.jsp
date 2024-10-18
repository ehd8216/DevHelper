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
            <tbody id="recentJobsTable">
            </tbody>
        </table>
    </div>

    <script>
        // 쿠키에서 JSON 문자열을 객체로 읽어오는 함수
        function getCookieWithObject(name) {
            const nameEQ = name + "=";
            const ca = document.cookie.split(';');

            for (let i = 0; i < ca.length; i++) {
                let c = ca[i].trim();
                if (c.indexOf(nameEQ) == 0) {
                    const jsonString = decodeURIComponent(c.substring(nameEQ.length, c.length));
                    try {
                        const parsedData = JSON.parse(jsonString);
                        // 반환된 값이 배열이 아닌 경우 빈 배열로 초기화
                        return Array.isArray(parsedData) ? parsedData : [];
                    } catch (e) {
                        console.error("쿠키 데이터 파싱 오류:", e);
                        return []; // 오류 발생 시 빈 배열 반환
                    }
                }
            }
            return []; // 쿠키가 없는 경우 빈 배열 반환
        }

        // 최근 본 공고를 로드하는 함수
       function loadRecentJobs() 
        {
		    const recentJobs = getCookieWithObject('recentJob'); // 쿠키에서 배열 가져오기
		    console.log(recentJobs); // 최근 본 공고의 내용을 로그로 확인
		    const tableBody = document.querySelector('#recentJobsTable');

    		// 공고 정보가 존재하는 경우 테이블에 추가
		    if (recentJobs.length > 0) 
		    {
		        let value = ""; // 초기화
		
		        for (let i = 0; i < recentJobs.length; i++) 
		        {
		            const job = recentJobs[i];
		            value += "<tr data-sn='"+job.recrutPblntSn+"'> "+
		                "<td>" + (job.instNm || 'N/A') + "</td>" +
		                "<td>" + (job.recrutPbancTtl || 'N/A') + "</td>" +
		                "<td>" + (job.pbancEndYmd || 'N/A') + "</td>" +
		                "<td>" + (job.ncsCdNmLst || 'N/A') + "</td>" +
		                "<td>" + (job.hireTypeNmLst || 'N/A') + "</td>" +
		                "<td>" + (job.recrutSeNm || 'N/A') + "</td>" +
		                "<td>" + (job.workPlcNm || 'N/A') + "</td>" +
		                "</tr>";
		        }
		
		        tableBody.innerHTML = value; // 테이블에 추가
		    } 
		    else
		    {
		        console.log("최근 본 공고가 없습니다.");
		    }
		}
       $(document).on("click", "#result1>tbody>tr", function()
       {
    	    const sn = $(this).data("sn");
    	    location.href = "detail.wo?sn=" + sn; 
    	});
        window.onload = function() {
            loadRecentJobs();
        };
    </script>

</body>


</html>