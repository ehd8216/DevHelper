<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
    <div class="outer">
        <div class="repoDetail">
            <div id="btns">
                <button id="issues">Issues</button>
                <button>Pull Request</button>
                <button>milestone</button>
                <button>commit</button>
            </div>

            <h1 id="repoName">${repo.name}</h1>
            <h1 id="writer">${writer}</h1>
            <h1>${repo.language}</h1>
        </div>

    </div>
<script>
$(function(){
    $(".repoDetail #issues").click(function(){
      var writer = $("#writer").text();
      console.log(writer)// writer가 없을 경우 기본값 설정
      location.href="issueslist.re?repoName=" + $("#repoName").text()+"&writer=" + writer;
    });
});
</script>
</body>
</html>