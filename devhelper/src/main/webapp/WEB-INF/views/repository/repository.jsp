<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- w3school bootstrap 링크 4개 Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
  .repoList{
    margin: auto;
    width: 80%;
    backdrop-filter: blur(5px);
    position: relative;
  }
  .repoTable{
    margin: auto;
    width: 100%;
  }
  #repoHead{
    height: 80px;
    font-size: 24px;
    text-align: center;
  }
  #repoHead tr td{
    padding-top: 20px;
  }
  #repoBody{
    font-size: 18px;
    text-align: center;
  }
  #repoBody tr{
    height: 70px;
    cursor: pointer;
  }
  #repoBody tr:hover{
    background-color: rgba(155, 155, 155, 0.3);
    transition: .3s;
  }
  #nullRepo{
  	height: 500px;
  }  
  .modal{
    transition: .5s;
  }
  .btn{
  float: right;
  margin-right: 35px;
  }
  
</style>
</head>
<body>
  <jsp:include page="../common/menubar.jsp" />
  
  	<c:if test="${ not empty alertMsg }">
		<script>
			toastr.success("${alertMsg}");
		</script>
		<c:remove var="alertMsg" />
	</c:if>
		
  <div class="outer">
      <div class="repoList">
        <button class="btn btn-primary" data-toggle="modal" data-target="#createRepo">
          레파지토리 생성
        </button>
      	<c:choose>
      	
      		<c:when test="${ repoList eq null }"> <!-- 레파지토리가 없을 경우 레파지토리 생성 버튼만 활성화 -->
      			<div id="nullRepo">
      				레파지토리가 존재하지 않습니다... 레파지토리를 추가해주세요!
      			</div>
      		</c:when>
      		
      		<c:otherwise> <!-- 전체 레파지토리 리스트 출력 -->
		        <table border="1" class="repoTable">
		          <thead id="repoHead">
		            <tr>
		              <th>Name</th>
		              <th>Description</th>
		              <th>Visibility</th>
		              <th>Create</th>
		              <td>Sub</td>
		            </tr>
		          </thead>
		          <tbody id="repoBody">
		          <c:forEach var="r" items="${ repoList }">
		            <tr>
		              <td id="repoName">${ r.repoName }</td>
		              <td>${ r.repoDescription }</td>
		              <td>${ r.visibility }</td>
		              <td>${ r.createDate }</td>
		              <td id="repoBtn">
		                <button class="btn btn-danger" id="deleteRepo" onclick="deleteRepo('${r.repoUrl}')">삭제</button>
		                <button class="btn btn-success" id="invite" data-toggle="modal" data-target="#inviteRepo" onclick="reUserUrlq('${r.repoUrl}')">초대</button>
		              </td>
                  <input id="repoUrl" class="url" type="hidden" value="${r.repoUrl}">
		            </tr>
		          </c:forEach>
		          </tbody>
		        </table>
			</c:otherwise>
			
        </c:choose>
      </div>
  </div>

  <script>
    let reUserUrl = "";
  $(function(){

	    $("#repoBody tr td").click(function(){
	      if($(this).attr('id') !== 'repoBtn'){
	        // 현재 클릭한 row에서 url input의 값을 가져옴
	        var repoName = $(this).parent().find("#repoName").text();
	        var repoUrl = $(this).parent().find(".url").val();
	        
	        // repoName과 repoUrl을 파라미터로 추가하여 이동
	        location.href="repoDetail.re?repoName=" + repoName + "&repoUrl=" + encodeURIComponent(repoUrl);
	      }
	    });


	  });
  
  
  

    function reUserUrlq(repoUrl){
      reUserUrl = repoUrl.substr(29);
    }

    function deleteRepo(repoUrl){
      let deleteRepo1 = confirm("정말로 삭제하시겠습니까?");
      if(deleteRepo1){
    	  let deleteRepo2 = confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?");
        if(deleteRepo2){
          reUserUrlq(repoUrl);
          location.href="deleteRepo.re?reUserUrl=" + reUserUrl;
        }
      }
    }
    
    function inviteRepo(){
    	const inviteUserName = $("#inviteUserName").val();
    	location.href="inviteRepo.re?inviteUserName=" + inviteUserName + "&reUserUrl=" + reUserUrl;
    }
    
  </script>

  <!-- 레파지토리 생성용 모달 -->
  <div class="modal" id="createRepo">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Create Repository</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body">
          <form action="createRepo.re" method="get">
            제목 : <input type="text" name="repoName" id=""> <br><br>
            부제목 : <input type="text" name="repoDescription" id=""> <br><br>
            private : <input type="radio" name="visibility" id="" value="true"> <br>
            public : <input type="radio" name="visibility" id="" value="false"> <br>
            README : <input type="checkbox" name="readMe" value="true"> <br><br>
            <input type="hidden" name="readMe" value=""> <!-- readMe 안할 시 넘길 값 -->
            <button type="submit">생성</button>
          </form>
        </div>

      </div>
    </div>
  </div>
  
  
  <!-- 레파지토리 초대용 모달 -->
  <div class="modal" id="inviteRepo">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Invite Repository</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
            이름 : <input type="text" name="inviteUserName" id="inviteUserName"> <br><br>
            <button onclick="inviteRepo()">초대</button>
        </div>
      </div>
    </div>
  </div>

</body>
</html>