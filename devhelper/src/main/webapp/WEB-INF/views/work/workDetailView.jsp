<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    .info-table th{
        background-color: antiquewhite;
    }

    .text-nav{
        width: 1650px;
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
        <h1 align="left">한국체육산업개발 공고</h1>
        <br>
        <a href=""><h2 align="left">[원문]</h2></a>
    </div>
   
    <table class="condition" style="border: 1px solid lightgray">
        <tr>
            <td>공고기간</td>
            <td>채용분야</td>
            <td>대체인력여부</td>
        </tr>
        <tr>
            <td>2024-10-2</td>
            <td>건설기계</td>
            <td>아니오</td>
        </tr>
        <tr>
            <td>고용형태</td>
            <td>학력정보</td>
            <td>근무지</td>
        </tr>
        <tr>
            <td>청년체험</td>
            <td>학력무관</td>
            <td>강남</td>
        </tr>
       
    </table>
    <br>

    <table class="info-table" style="border: 1px solid lightgray" >
        <tr>
            <th>응시자격</th>
            <td>ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ
                ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ
            </td>
        </tr>
        <tr style="height: 20px;">
            <th>우대조건</th>
            <td>국가유공자</td>
        </tr>
        <tr style="height: 150px;">
            <th>전형절차 방법</th>
            <td>서류->면접->최종합격</td>
        </tr>
        <tr style="height: 20px;">
            <th >공고문</th>
            <td>.zip 파일</td>
        </tr>
        <tr style="height: 20px;">
            <th s>입사지원서</th>
            <td>.png 파일</td>
        </tr>
    </table>
    <br>
    <br>

    <a href="list.wo">목록으로</a>
</div>

<script>
	$.ajax({
		uri:"detail.wo",
		data:{},
		success:function(result){
			console.log(result)
		},error:function(){
			console.log("detail API 에러")
		}
	})
</script>
</body>
</html>