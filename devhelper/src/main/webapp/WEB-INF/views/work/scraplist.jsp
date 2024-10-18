<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Scrap List View</title>
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

  <div class="title" align="center">스크랩한 공고</div>


  <div class="workInfo" align="center" >
    <table class="list-area" id = "result1">
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
      <tbody>
      <c:forEach var="s" items="${sc}">
      	<tr>
      	  <input type="hidden" value="${s.recrutPblntSn}">
          <td>${s.instNm}</td>
          <td>${s.recrutPbancTtl }</td>
          <td>${s.pbancEndYmd }</td>
          <td>${s.ncsCdNmLst }</td>
          <td>${s.hireTypeNmLst }</td>
          <td>${s.recrutSeNm }</td>
          <td>${s.workRgnNmLst }</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <button id="back-to-top"><span class="material-symbols-outlined">arrow_upward</span></button>
  <div id="pagination" style="text-align: center; margin-top: 20px;">
    <button id="prevPage">Prev</button>
    <span id="page-numbers"></span>
    <button id="nextPage">Next</button>
  </div>
  <script>
	$(document).on("click", "#result1>tbody>tr", function() {
	    const sn = $(this).find('input[type="hidden"]').val();
	
	    location.href = "detail.wo?sn=" + sn;

	});
</script>
</body>
</html>