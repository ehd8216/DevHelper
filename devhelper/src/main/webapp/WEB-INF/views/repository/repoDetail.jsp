<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- w3school bootstrap 링크 4개 Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script> -->
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Material icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=folder" />

<style>
    .repoDetail{
        height: auto;
        width: 90%;
        margin: auto;
        backdrop-filter: blur(5px);
        display: flex;
    }
    #btns button{
        margin: 50px 20px 0 0;
        padding-top: 10px;
        width: 8%;
        height: 40px;
        position: fixed;
    }
    #repoInfo{
        display: flex;
        position: fixed;
    }
    #repoInfo h1{
        margin: 20px 10px;
        font-size: 24px;
    }
    #repoDetailFile{
        margin: 10px 0 0 10px;
        
    }
    #repoDetailFile span{
        margin-top: 10px;
        font-size: 20px;
    }
    #repoCommitList{
        display: flex;
        justify-content: flex-start;
    }
    .material-symbols-outlined {
    font-variation-settings:
    'FILL' 1,
    'wght' 400,
    'GRAD' 0,
    'opsz' 24
    }
    #dual{
        width: 40%;
        height: 695px;
        overflow: auto;
        margin-top: 100px;
    }
    #dual2{
        width: 55%;
        margin-left: 50px;
    }
</style>

</style>

</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
    <div class="outer">
        <div class="repoDetail">
            <div id="repoInfo">
                <h1 id="repoName">${repo.name}</h1> 
                <h1 id="writer">${writer}</h1>
                <h1>${repo.language}</h1>
            </div>
            <div id="btns">
                <button style="left: 0;" class="btn btn-danger" id="issues">Issues</button>
                <button style="left: 150px;" class="btn btn-warning" id="test">milestone</button>
                <button style="left: 300px;" class="btn btn-info" id="commit">commit</button>
                <button style="left: 450px;" class="btn btn-primary">Pull Request</button>
            </div>
            <br>
            <div id="dual">
                <div id="repoDetailFile">
                    <!-- 폴더가 위로가게 배치 -->
                    <c:forEach var="l" items="${ repoDirectory }">
                        <c:if test="${ l.isFile eq false }">
                            <span class="material-symbols-outlined" style="color: #2854C5;">folder</span>
                            <span>${ l.dirName }</span>
                            <br>
                        </c:if>
                    </c:forEach>
                    <!-- 폴더가 아닌 파일들은 아래로 위치 -->
                    <c:forEach var="l" items="${ repoDirectory }">
                        <c:if test="${ l.isFile eq true }">
                            <span class="material-symbols-outlined">description</span>
                            <span>${ l.dirName }</span>
                            <br>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <div id="dual2" style="border: 1px solid black;">
                <iframe width="100%" height="100%" src="commitList.re?repoUserUrl=${ url }"></iframe>
            </div>
        </div>

    </div>
<script>
$(function(){
    // issue 화면 ㄱㄱ
    $(".repoDetail #issues").click(function(){
      var writer = $("#writer").text();
      location.href="issueslist.re?repoName=" + $("#repoName").text()+"&writer=" + writer;
    });
    
    // commit 화면 ㄱㄱ
    $(".repoDetail #commit").click(function(){
    	let repoUserUrl = $("#writer").text() + '/' + $("#repoName").text();
        location.href="commitList.re?repoUserUrl=" + repoUserUrl;
    })
    
    $(".repoDetail #test").click(function(){
        location.href="test.re";
    })
});
</script>
</body>
</html>