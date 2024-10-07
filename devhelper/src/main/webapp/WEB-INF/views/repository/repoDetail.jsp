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

            <h1 id="repoName">${repo.description}</h1>
            <h1>${loginMember.gitNick}</h1>
            <h1>${repo.language}</h1>
        </div>

    </div>
<script>
$(function(){
    $(".repoDetail #issues").click(function(){
      location.href="issueslist.re?repoName=" + $("#repoName").text();
    })
  })
</script>
</body>
</html>