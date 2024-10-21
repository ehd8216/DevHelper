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
        height: 800px;
        width: 85%;
        margin: auto;
        backdrop-filter: blur(5px);
        display: flex;
    }
    .btn{
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
    #repoDetailFile div{
        border-radius: 5px;
        cursor: pointer;
        transition: .2s;
    }
    #repoDetailFile div:hover{
        background-color: rgb(185, 185, 185);
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
        height: 698px;
        overflow: auto;
        margin-top: 160px;
    }
    #dual::-webkit-scrollbar{
        width: 1px;
    }
    #dual::-webkit-scrollbar-button{
        display: none;

    }
    #dual2{
        width: 70%;
        margin-left: 100px;
        border-radius: 10px;
        border: 1px solid #e5e5e5;
        display: none;
    }
    .gitIcon{
        position: absolute;
        left: 5px;
        top: 12px;
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
                <button style="left: 0;" class="btn btn-danger" id="issues">
                    <svg class="gitIcon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16">
                        <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3Z"></path>
                        <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0ZM1.5 8a6.5 6.5 0 1 0 13 0 6.5 6.5 0 0 0-13 0Z"></path>
                    </svg>Issues</button>

                <button style="left: 150px;" class="btn btn-primary">
                    <svg class="gitIcon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16">
                        <path d="M1.5 3.25a2.25 2.25 0 1 1 3 2.122v5.256a2.251 2.251 0 1 1-1.5 0V5.372A2.25 2.25 0 0 1 1.5 3.25Zm5.677-.177L9.573.677A.25.25 0 0 1 10 .854V2.5h1A2.5 2.5 0 0 1 13.5 5v5.628a2.251 2.251 0 1 1-1.5 0V5a1 1 0 0 0-1-1h-1v1.646a.25.25 0 0 1-.427.177L7.177 3.427a.25.25 0 0 1 0-.354ZM3.75 2.5a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm0 9.5a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm8.25.75a.75.75 0 1 0 1.5 0 .75.75 0 0 0-1.5 0Z"></path>
                    </svg>Pull Request</button>


                <button style="left: 300px;" class="btn btn-info" id="commit">
                    <svg class="gitIcon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16">
                        <path d="M11.93 8.5a4.002 4.002 0 0 1-7.86 0H.75a.75.75 0 0 1 0-1.5h3.32a4.002 4.002 0 0 1 7.86 0h3.32a.75.75 0 0 1 0 1.5Zm-1.43-.75a2.5 2.5 0 1 0-5 0 2.5 2.5 0 0 0 5 0Z"></path>
                    </svg>commit</button>


                <select name="bOption" class="btn btn-secondary" style="left: 450px; top: 60px;">
              		<c:forEach var="b" items="${ bList }">
              			<c:if test="${ b.branchName eq 'main' }">
                   			<option value="${ b.branchName }" selected>${ b.branchName }</option>
                   		</c:if>
                  	</c:forEach>
                  	<c:forEach var="b" items="${ bList }">
                   		<c:if test="${ b.branchName ne 'main' }">
                   			<option value="${ b.branchName }">${ b.branchName }</option>
                   		</c:if>
                   	</c:forEach>
                </select>


                <button style="left: 450px;" class="btn btn-secondary" id="branch">
                    <svg class="gitIcon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16">
                        <path d="M9.5 3.25a2.25 2.25 0 1 1 3 2.122V6A2.5 2.5 0 0 1 10 8.5H6a1 1 0 0 0-1 1v1.128a2.251 2.251 0 1 1-1.5 0V5.372a2.25 2.25 0 1 1 1.5 0v1.836A2.493 2.493 0 0 1 6 7h4a1 1 0 0 0 1-1v-.628A2.25 2.25 0 0 1 9.5 3.25Zm-6 0a.75.75 0 1 0 1.5 0 .75.75 0 0 0-1.5 0Zm8.25-.75a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5ZM4.25 12a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Z"></path>
                    </svg>branch</button>


            </div>

            <script>
                $(function(){
                    $("select[name=bOption]").change(function(){
                        location.href="branchDetail.re?branchName=" + $(this).val();
                    });
                })

            </script>

            <br>
            <div id="dual">
                <div id="repoDetailFile">
                    <!-- 폴더가 위로가게 배치 -->
                    <c:forEach var="l" items="${ repoDirectory }">
                        <div class="rd">
                            <c:if test="${ l.isFile eq false }">
                                <span class="material-symbols-outlined" style="color: #2854C5;">folder</span>
                                <span>${ l.dirName }</span>
                                <br>
                            </c:if>
                        </div>
                    </c:forEach>
                    <!-- 폴더가 아닌 파일들은 아래로 위치 -->
                    <c:forEach var="l" items="${ repoDirectory }">
                        <div class="rd">
                            <c:if test="${ l.isFile eq true }">
                                <span class="material-symbols-outlined">description</span>
                                <span>${ l.dirName }</span>
                                <br>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div id="dual2">
                <iframe id="iframe" width="100%" height="100%"></iframe>
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

            $("#commit").click(function(){
                $("#iframe").attr("src", "commitList.re?repoUserUrl=" + '${ url }')
                $("#dual2").css("display","block")
            })
            
            $("#branch").click(function(){
                $("#iframe").attr("src", "branch.re")
                $("#dual2").css("display","block")
            })
            
        });
    </script>
</body>
</html>