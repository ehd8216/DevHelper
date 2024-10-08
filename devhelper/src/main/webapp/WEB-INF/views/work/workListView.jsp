<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    body {
      height: 1500px;
    }

    .material-symbols-outlined {
      font-variation-settings:
        'FILL' 0,
        'wght' 400,
        'GRAD' 0,
        'opsz' 24;
    }

    .title {
      font-size: 40px;
      font-weight: bold;
      padding-top: 80px;
      padding-bottom: 40px;
    }

    .search-bar-container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 20px;
    }

    .search-bar {
      font-size: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 10px;
      display: none;
    }

    .search-bar input {
      padding: 10px;
      font-size: 20px;
      width: 500px;
    }

    .search-bar button {
      padding: 10px 20px;
      font-size: 20px;
      cursor: pointer;
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
      border: none;
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

    .search-icon-only {
      display: flex;
      cursor: pointer;
    }

    input[name="place"]:focus,
    input[name="job"]:focus {
      caret-color: transparent;
    }

    /* Back to Top button styling */
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

    #back-to-top:hover { background-color: #555;}

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

  <div class="title" align="center">채용 공고 확인하기</div>

  <div class="search-bar-container">
    <div class="search-bar" id="search-bar">
      <span class="material-symbols-outlined">search</span>
      <input type="text" name="keyword" placeholder="검색어를 입력하세요">
      <input type="text" name="job" placeholder="희망 분야를 선택해주세요">
      <button>찾기</button>
      <span class="material-symbols-outlined" id="close-btn">close</span>
    </div>
    
    <div class="search-icon-only" id="search-icon-only">
      <span class="material-symbols-outlined">search</span>
    </div>
  </div>

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
          <th width="65px">스크랩</th>
        </tr>
      </thead>

      <tbody>
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
  // 리스트 API 스크립트
  let currentPage = 1;
  let pageSize = 15;
  let totalPages = 10;
  
  $(function(){
	  loadData(currentPage);
    updatePagination(currentPage);
  });
  
  function loadData(page){
		$.ajax({
			url:"work.wo",
			data:{pageNo:page, numOfRows:pageSize},
			success:function(data){
				console.log(data);
				let items = data.result;
				let html = "";
				
				$.each(items,function(index,job){
					 html += "<tr data-sn='"+job.recrutPblntSn+"'> ";
			          html += "<td>" + job.instNm + "</td>";
			          html += "<td>" + job.recrutPbancTtl + "</td>";
			          html += "<td>" + job.pbancEndYmd + "</td>";
			          html += "<td>" + job.ncsCdNmLst + "</td>";
			          html += "<td>" + job.hireTypeNmLst + "</td>";
			          html += "<td>" + job.recrutSeNm + "</td>";
			          html += "<td>" + job.workRgnNmLst + "</td>";
			          html += "<td><span class='material-symbols-outlined favorite'>favorite</span></td>";
			          html += "</tr>";
				});
				
				$("#result1 tbody").html(html);	

        		$("#currentPage").text(currentPage);
			},
			error:function(){
				console.log("API AJAX에러")
			}
		})
	}
  
  
  // 디테일로 넘어가는 스크립트(ssn 줘야함)
  $(document).on("click", "#result1>tbody>tr", function() {
      const sn = $(this).data("sn");
      location.href = "detail.wo?sn=" + sn; 
      console.log(sn)
  });
  
    // 백 투더 탑 스크립트
     $(document).ready(function () {
      
      $('#search-icon-only').click(function () {
        $('#search-bar').slideDown(); 
        $('#search-icon-only').hide();
    });

      $('#close-btn').click(function () {
        $('#search-bar').slideUp(); 
        $('#search-icon-only').show();
    });

        $('#back-to-top').click(function () {
          $('html, body').animate({ scrollTop: 0 }, 'slow');
          return false;
        });
      });

    // 페이지 스크립트
    function updatePagination(page) {
    let pageNumbersHTML = "";
    let startPage = Math.max(1, page - 2); 
    let endPage = Math.min(totalPages, startPage + 4); 

    for (let i = startPage; i <= endPage; i++) {
        if (i === page) {
          pageNumbersHTML += '<button class="page-button active" data-page="' + i + '">' + i + '</button>';
        } else {
          pageNumbersHTML += '<button class="page-button" data-page="' + i + '">' + i + '</button>';
        }
    }

    $("#page-numbers").html(pageNumbersHTML);
    $("#prevPage").prop('disabled', page === 1);
    $("#nextPage").prop('disabled', page === totalPages);
  }

    $(document).on("click", ".page-button", function(){
        const selectedPage = $(this).data("page");
        currentPage = selectedPage;
        loadData(currentPage);
        updatePagination(currentPage);
    });

    $("#prevPage").click(function(){
        if (currentPage > 1) {
            currentPage--;
            loadData(currentPage);
            updatePagination(currentPage);
        }
    });

    $("#nextPage").click(function(){
        if (currentPage < totalPages) {
            currentPage++;
            loadData(currentPage);
            updatePagination(currentPage);
        }
    });
  </script>
</body>

</html>
