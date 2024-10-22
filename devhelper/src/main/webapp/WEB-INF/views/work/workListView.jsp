<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
  

 #job-dropdown-btn {
    height: 24px;
    padding: 10px 20px;
    font-size: 18px;
    cursor: pointer;
    border: 1px solid #ccc;
    background-color: white;
    
}

#job-dropdown-btn:hover{
  background-color: #f0f0f0;
}

.dropdown-grid-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    width: 100%;
    max-width: 800px;
    border: 1px solid #ccc;
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
    z-index: 1;
    padding: 10px;
    left: 525px;
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 5 columns */
    grid-template-rows: repeat(2, 1fr);    /* 2 rows */
    gap: 10px;
    width: 100%;
    max-width: 1000px;
    margin: 0 auto;
}

.grid-item {
    padding: 15px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    text-align: center;
    cursor: pointer;
}

.grid-item:hover {
    background-color: #f0f0f0;
}
  </style>
</head>

<body>
  <jsp:include page="../common/menubar.jsp" />

  <div class="title" align="center">채용 공고 확인하기</div>
  <div class="search-bar-container">
    <div class="search-bar" id="search-bar" style="display: none;">
     
      <input type="text" name="keyword" placeholder="검색어를 입력하세요">
      
      <div class="dropdown">
        <div id="job-dropdown-btn">희망 분야를 선택해주세요</div>
        <div id="job-dropdown-grid" class="dropdown-grid-content">
            <div class="grid-container">
              <div class="grid-item" id="management_office" data-job="R600002">경영·사무·회계</div>
				<div class="grid-item" id="mechanical" data-job="R600015">기계</div>
				<div class="grid-item" id="education" data-job="R600004">교육·자연·사회과학</div>
				<div class="grid-item" id="construction" data-job="R600014">건설</div>
				<div class="grid-item" id="materials" data-job="R600016">재료</div>
				<div class="grid-item" id="chemical" data-job="R600017">화학</div>
				<div class="grid-item" id="electrical" data-job="R600019">전기·전자</div>
				<div class="grid-item" id="information" data-job="R600020">정보통신</div>
				<div class="grid-item" id="environment" data-job="R600023">환경·에너지·안전</div>
				<div class="grid-item" id="research" data-job="R600025">연구</div>  
            </div>
        </div>
    </div>

      <button id="btn1">찾기</button>
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
  let ncsCdLst;
  let recrutPbancTtl;
  let scrapSnList = [];
  $(function(){
	  loadData(currentPage);
      updatePagination(currentPage);
      scrapnum();
      
  });
  
  function loadData(page){
		$.ajax
		({
			url:"work.wo",
			data:{
		        pageNo:page, 
		        numOfRows:pageSize,
		        ncsCdLst:ncsCdLst,
		        recrutPbancTtl: recrutPbancTtl,
      		},
			success:function(data)
			{
				console.log(data);
				let items = data.result;
				let html = "";
        
				
				$.each(items,function(index,job)
				{
					 html += "<tr data-sn='"+job.recrutPblntSn+"'> ";
			          html += "<td>" + job.instNm + "</td>";
			          html += "<td>" + job.recrutPbancTtl + "</td>";
			          html += "<td>" + job.pbancEndYmd + "</td>";
			          html += "<td>" + job.ncsCdNmLst + "</td>";
			          html += "<td>" + job.hireTypeNmLst + "</td>";
			          html += "<td>" + job.recrutSeNm + "</td>";
			          html += "<td>" + job.workRgnNmLst + "</td>";
			          if (scrapSnList.includes(job.recrutPblntSn)) 
			          {
			              html += "<td><span id='scrap2' class='material-symbols-outlined favorite' style='font-variation-settings: \"FILL\" 1; color:red;'>favorite</span></td>";
			          } 
			          else
			          {
			              html += "<td><span id='scrap' class='material-symbols-outlined favorite'>favorite</span></td>";
			          }
			          	html += "</tr>";
	            });


				
				 $("#result1 tbody").html(html);	
       			 $("#currentPage").text(currentPage);
			},
			error:function()
			{
				console.log("API AJAX에러")
			}
		})
	}

  function scrapnum() {
	  $.ajax({
	    url: "scrapcheck.wo",
	    data: { memNo: "${loginMember.memNo}" },
	    success: function(SnList) {
	      scrapSnList = SnList; // 스크랩된 목록을 전역 변수에 저장
	    },
	    error: function() {
	      console.log("스크랩 목록을 불러오는 중 에러 발생");
	    }
	  });
	}
 //쿠키부분-----------------------------------------------
function setCookieWithObject(name, object, expireDays) {
    const date = new Date();
    date.setTime(date.getTime() + (expireDays * 24 * 60 * 60 * 1000));
    const expires = "expires=" + date.toUTCString();
    document.cookie = name + "=" + encodeURIComponent(JSON.stringify(object)) + ";" + expires + ";path=/";
}

// 쿠키에서 JSON 문자열을 객체로 읽어오는 함수
function getCookieWithObject(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(';');

    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) {
            const jsonString = decodeURIComponent(c.substring(nameEQ.length, c.length));
            try {
                const parsedData = JSON.parse(jsonString);
                // 반환된 값이 배열이 아닌 경우 빈 배열로 초기화
                return Array.isArray(parsedData) ? parsedData : [];
            } catch (e) {
                console.error("쿠키 데이터 파싱 오류:", e);
                return []; // 오류 발생 시 빈 배열 반환
            }
        }
    }
    return []; // 쿠키가 없는 경우 빈 배열 반환
}
//최근 본 공고를 쿠키에 저장하는 함수
function saveRecentJob(job) {
    const recentJobs = getCookieWithObject('recentJob'); // 쿠키에서 배열 가져오기
    // 배열이 10개 이상일 경우 가장 오래된 항목 삭제
    if (recentJobs.length >= 3) {
        recentJobs.shift(); // 가장 오래된 항목 삭제
    }
    recentJobs.push(job); // 새로운 공고 추가
    setCookieWithObject('recentJob', recentJobs, 7); // 쿠키에 저장
}
  // 디테일로 넘어가는 스크립트(sn 줘야함)
 $(document).on("click", "#result1>tbody>tr", function() {
    const jobInfo = {
        recrutPblntSn: $(this).data("sn"), 
        instNm: $(this).find("td").eq(0).text(),
        recrutPbancTtl: $(this).find("td").eq(1).text(),
        pbancEndYmd: $(this).find("td").eq(2).text(),
        ncsCdNmLst: $(this).find("td").eq(3).text(),
        hireTypeNmLst: $(this).find("td").eq(4).text(),
        recrutSeNm: $(this).find("td").eq(5).text(),
        workPlcNm: $(this).find("td").eq(6).text()
    };

    // 쿠키에 객체로 저장 (7일 유효)
    saveRecentJob(jobInfo); // 최근 본 공고 저장
    const sn = $(this).data("sn");
    setTimeout(() => {
        location.href = "detail.wo?sn=" + sn; 
    }, 100); // 100ms 지연
});

  //scrap 전파방해 스크랩
  $(document).on("click", "#scrap", function(event) {
	    event.stopPropagation(); 
	    event.preventDefault();
	    const sn = $(this).closest('tr').data("sn");
	    $.ajax
	    ({
	    	url:"scrap.wo",
	    	data:{sn},
	    	success: function(result) {
	            console.log(result);

	            if (result == -1) {
	                alert('로그인 후 이용 가능한 서비스입니다.');  
	            } else if (result > 0) {
	                alert('스크랩이 성공적으로 완료되었습니다!');  
	                location.reload(); // 스크랩 삭제 후 새로고침
	            } else {
	                alert('스크랩에 실패했습니다. 다시 시도해주세요.');  
	            }
	            
	        },
	        error: function() {
	            alert('서버 에러가 발생했습니다. 잠시 후 다시 시도해주세요.');
	        }
	    });
	});
  //스크랩 취소 스크립트
  $(document).on("click", "#scrap2", function(event) {
	    event.stopPropagation(); 
	    event.preventDefault();
	    const sn = $(this).closest('tr').data("sn");
	    $.ajax
	    ({
	    	url:"scrapdelete.wo",
	    	data:{sn},
	    	success: function(result) {
	            console.log(result);

	            if (result > 0) {
	                alert('스크랩이 성공적으로 삭제되었습니다.');  
	                location.reload(); // 스크랩 삭제 후 새로고침
	            }else {
	                alert('스크립 삭제에 실패했습니다.');  
	            }
	            
	        },
	        error: function() {
	            alert('서버 에러가 발생했습니다. 잠시 후 다시 시도해주세요.');
	        }
	    });
	});
    // 백 투더 탑 스크립트
     $(document).ready(function () {
      
      $('#search-icon-only').click(function () {
        $('#search-bar').fadeIn(400).css('display', 'flex');
        $('#search-icon-only').hide();
    });

      $('#close-btn').click(function () {
        $('#search-bar').css('display','none')
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


    // 검색 드롭다운
     
    $(document).ready(function () {
    $('#job-dropdown-btn').click(function () {
        $('#job-dropdown-grid').toggle();
    });

    $(document).mouseup(function(e) {
        let container = $("#job-dropdown-grid");
        if (!container.is(e.target) && container.has(e.target).length === 0) {
            container.hide();
        }
    });
	
  
    $(document).on('click', '.grid-item', function() {
      ncsCdLst = $(this).data("job");
      $('#job-dropdown-btn').text($(this).text());
      $('#job-dropdown-grid').hide(); 
      currentPage = 1;
      loadData(currentPage); 
      console.log(ncsCdLst)
     });

    $(document).on('click', '#btn1', function() {
    const searchTerm = $('input[name="keyword"]').val().trim();  // Get the search term
      recrutPbancTtl =searchTerm;
      currentPage = 1
      console.log(recrutPbancTtl)
      loadData(currentPage);  
    });
  
});
  </script>
</body>

</html>
