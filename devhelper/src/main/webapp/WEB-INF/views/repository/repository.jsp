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
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createRepo">
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
		                <button id="inviteRepo" onclick="inviteRepo()">초대</button>
		                <button id="deleteRepo" onclick="deleteRepo('${ r.repoName }')">삭제</button>
		              </td>
		            </tr>
		          </c:forEach>
		          </tbody>
		        </table>
			</c:otherwise>
			
        </c:choose>
      </div>
  </div>

  <script>
    $(function(){

      $("#repoBody tr td").click(function(){  
        if($(this).attr('id') != 'repoBtn'){
          location.href="repoDetail.re?repoName="+$(this).parent().children("#repoName").text();
        }
      })

    })

    function inviteRepo(){
      location.href="inviteRepo.re";
    }

    function deleteRepo(repoName){
      location.href="deleteRepo.re?repoName=" + repoName;
    }
    
  </script>

  <!-- The Modal -->
  <div class="modal" id="createRepo">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Create Repository</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body">
          <form action="createRepo.re" method="post">
            제목 : <input type="text" name="repoName" id=""> <br><br>
            부제목 : <input type="text" name="repoDescription" id=""> <br><br>
            private : <input type="radio" name="visibility" id="" value="true"> <br>
            public : <input type="radio" name="visibility" id="" value="false"> <br>
            README : <input type="checkbox" name="readMe" value="true"> <br><br>
            <button type="submit">생성</button>
          </form>
        </div>

      </div>
    </div>
  </div>

</body>
</html>