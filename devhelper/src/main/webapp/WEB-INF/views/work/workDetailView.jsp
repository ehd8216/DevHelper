<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    .info-table th{
        background-color: antiquewhite;
    }

    .text-nav{
        width: 1650px;
        padding-top: 80px;
        padding-bottom: 10px;
    }
    .text-nav h1{
        padding-top: 25px;
        font-size: 20px;
    }
    .condition{
        width: 1650px;
        text-align: center;
    }
    .condition td{
        padding-top: 10px;
    }
    .condition tr:nth-child(1),
    .condition tr:nth-child(3){
        color: #6F809C;
    }
    .info-table tr{
        border-bottom: 1px solid lightgray;
    }
 
    .info-table th{
        width: 150px;
        text-align: center; /* Center text horizontally */
        vertical-align: middle; /* Center text vertically */
    }
    .info-table td{
        width: 1500px;
        padding: 2.5px 0 2.5px 0;
    }

</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp" />
<jsp:include page="../common/backToTop.jsp" />

<div class="main" align="center">

    <div class="text-nav" align="center">
        <h1 align="left"><div id="recru-title"></div></h1>
        <br>
        <a href=""><h2 align="left">[원문]</h2></a>
    </div>
   
    <table class="condition" style="border: 1px solid lightgray">
    <tr>
        <td>채용 기업</td>
        <td>공고 종료일</td>
        <td>대체인력 여부</td>
    </tr>
    <tr>
        <td id="condition-instNm"></td>  <!-- 채용회사명 -->
        <td id="condition-end-date"></td>    <!-- 공고 종료일 -->
        <td id="condition-substitute"></td>  <!-- 대체인력 여부 -->
    </tr>
    <tr>
        <td>채용분야</td>
        <td>고용형태</td>
        <td>근무지</td>
    </tr>
    <tr>
        <td id="condition-job-type"></td>    <!-- 채용분야 -->
        <td id="hire-type"></td>             <!-- 고용형태 -->
        <td id="work-region"></td>           <!-- 근무지 -->
    </tr>
</table>
<br>

<table class="info-table" style="border: 1px solid lightgray">
    <tr>
        <th>응시자격</th>
        <td id="eligibility"></td> <!-- 응시자격 -->
    </tr>
    <tr>
        <th>우대내용</th>
        <td id="preferred"></td> <!-- 우대조건 -->
    </tr>
    <tr style="height: 20px;">
        <th>전형절차</th>
        <td id="selection-procedure"></td> <!-- 전형절차 방법 -->
    </tr>
    <tr style="height: 20px;">
    	<th>공고문</th>
    	<td id="job-announcement"></td> <!-- 공고문 -->
    </tr>
    <tr style="height: 20px;">
    	<th>입사지원서</th>
    	<td id="application-form"></td> <!-- 입사지원서 -->
    </tr>
</table>
    <br>
    <br>

    <a href="list.wo">목록으로</a>
</div>

<script>
$(document).ready(function() {
    var sn = "${sn}";  // JSP에서 sn 값을 가져옴

    $.ajax({
        url: "detailAPI.wo",
        type: "GET",
        data: { sn: sn },
        success: function(result) {
            // console.log(result.result);  // 콘솔에 데이터 출력 (디버깅용)
		
           
                const job = result.result;  
            	console.log(job);
            	// 공고제목
          		$("#recru-title").text(job.recrutPbancTtl)
            
				// 채용기업 이름
                $("#condition-instNm").text(job.instNm);
                
                // 공고종료일
                $("#condition-end-date").text(job.pbancEndYmd);

                // 채용분야
                $("#condition-job-type").text(job.ncsCdNmLst);

                // 대체인력 여부
                $("#condition-substitute").text(job.replmprYn === "Y" ? "예" : "아니오");

                // 고용형태
                $("#hire-type").text(job.hireTypeNmLst);

                // 근무지
                $("#work-region").text(job.workRgnNmLst);

                // 응시자격
                $("#eligibility").text(job.aplyQlfcCn);

                // 우대조건
                $("#preferred").text(job.prefCn);

                // 전형절차 방법
                $("#selection-procedure").text(job.scrnprcdrMthdExpln);             
          
                // 공고문
                const annUrl = job.files[0].url
                const annFileName = job.files[0].atchFileNm
                $("#job-announcement").html('<a href='+ annUrl + '>' + annFileName + '</a>');
                
                
                // 입사지원서
                const appUrl = job.files[1].url // 링크
                const appFileName = job.files[1].atchFileNm // 파일이름
                $("#application-form").html('<a href=' + appUrl  + '>'+appFileName+'</a>');   
             
                
        },
        error: function() {
            console.log("detail API 에러");
        }
    });
});

</script>
</body>
</html>