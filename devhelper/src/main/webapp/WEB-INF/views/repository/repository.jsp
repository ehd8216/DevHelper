<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css" integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous" />
<style>
  .repoList{
    border: 1px solid black;
    margin: auto;
    width: 80%;
  }
  .repoTable{
    border: 1px solid gray;
    margin: auto;
    width: 100%;
  }
  #repoHead{
    height: 50px;
    font-size: 24px;
  }
  #repoBody{
    text-align: center;
  }
  #repoBody tr{
    height: 70px;
    cursor: pointer;
  }
  #repoBody tr:hover{
    background-color: rgba(155, 155, 155, 0.3)
  }
  #nullRepo{
  	height: 500px;
  }  
  
</style>
</head>
<body>
  <jsp:include page="../common/menubar.jsp" />
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
		              <td>
		                <button>초대</button>
		                <button>삭제</button>
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

      $("#repoBody tr").click(function(){
        location.href="repoDetail.re?repoName=" + $(this).children("#repoName").text();
      })

      



    })

    
  </script>

  <!-- The Modal -->
  <div class="modal" id="createRepo">
    <div class="modal-dialog">
      <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal body -->
        <div class="modal-body">
          Modal body..
        </div>

        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>

      </div>
    </div>
  </div>

</body>
</html>