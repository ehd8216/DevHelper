<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
   <style>

        .dashboard-container {
            width: 70%; /* Width is 70% of the viewport */
            height: 100%; /* Height is 70% of the viewport */
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            margin: auto;
        }

        .icon-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            padding: 20px;
            text-align: center;
        }

        .icon-grid a {
            text-decoration: none;
            color: black;
        }

        .icon-grid div {
            padding: 20px;
            background-color: #f1f1f1;
            border-radius: 10px;
            transition: background-color 0.3s ease;
        }

        .icon-grid div:hover {
            background-color: #e9ecef83;
        }

        .icon-grid i {
            font-size: 30px;
            display: block;
            margin-bottom: 10px;
        }

        .list-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 100%;
            height: 70%
        }
		.list-section form
		{
			width: 100%;
            height: 100%
		}
        .list-section form ul {
            list-style: none;
            padding: 0;
            width: 100%;
            height: 100%
        }
        .list-section li {
        	display: flex; /* Flexbox를 사용하여 수평 정렬 */
    		align-items: center; /* 세로 중앙 정렬 */
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
            font-size: 18px;
            height: 13%;
        }
		.list-section li label {
		    width: 6%; /* 라벨의 너비를 30%로 설정 */
		    margin-right: 10px; /* 라벨과 입력 필드 사이의 간격 */
		    text-align: right;
		}
		
		.list-section li input,textarea {
		    width: 70%; /* 입력 필드의 너비를 70%로 설정 */
            border: none;
		}
        .list-section li input:focus
        {
            border: none;
        }
        .list-section li:last-child {
            border-bottom: none;
        }

        .list-section li a {
            text-decoration: none;
            color: black;
        }

        .list-section li a:hover {
            text-decoration: underline;
        }

        .list-section .new-tag {
            color: red;
            font-weight: bold;
        }

        .footer {
            text-align: center;
            padding: 10px;
            font-size: 14px;
            color: gray;
        }
        #bigBox
        {
        	width: 100%;
        	height: 900px
        }
        .update
        {
        	border: none;
            border-radius: 15%;
        	background-color: rgb(241, 179, 7);
        	color: rgb(255, 253, 253);
        	width: 76px;
        	height: 32px;
        }
        .update:hover
        {
            background-color: rgb(255, 253, 253);
        	color: rgb(241, 179, 7);
            border: .5px solid rgb(241, 179, 7);
            cursor: pointer;
            transition: .5s;
        }
    </style>
</head>
<body>
    <!-- Icon Grid Section -->
   <body>
    <jsp:include page="../common/menubar.jsp" />
    <div id="bigBox">
	    <div class="dashboard-container">
	        <!-- Icon Grid Section -->
	        <div class="icon-grid">
	            <a href="resume.re">
	                <div>
	                    <i class="bi bi-file-earmark-text"></i>
	                    <p>이력서 관리</p>
	                </div>
	            </a>
	            <a href="recent.wo">
	                <div>
	                    <i class="bi bi-search"></i>
	                    <p>최근 본 공고</p>
	                </div>
	            </a>
	            <a href="scraplist.wo?memNo=${loginMember.memNo}">
	                <div>
	                    <i class="bi bi-star"></i>
	                    <p>스크랩 공고</p>
	                </div>
	            </a>
	            <a href="userlist.me">
	                <div>
	                    <i class="bi bi-heart"></i>
	                    <p>친구신청</p>
	                </div>
	            </a>
	            <a href="#">
	                <div>
	                    <i class="bi bi-file-earmark"></i>
	                    <p>친구목록</p>
	                </div>
	            </a>
	        </div>
	
	        <!-- List Section -->
	        <div class="list-section">
			    <form action="update.me">
			        <ul>
			            <li>
			                <img style="width: 64px; height: 64px" src="${m.profile}">
			            </li>
			            <li>
			                <label for="gitNick">깃 닉네임:</label>
			                <input type="text" id="gitNick" name="gitNick" disabled value="${m.gitNick}">
			            </li>
			            <li>
			                <label for="memIntro">자기소개:</label>
			                <textarea type="text" id="memIntro" name="memIntro"  style="resize: none;">${m.memIntro}</textarea>
			            </li>
			            <li>
			                <label for="stackName">기술이름:</label>
			                <input type="text" id="stackName" name="stackName"  value="${m.stackName}">
			            </li>
			            <li>
			                <label for="team">가입일:</label>
			                <input type="text" id="team" name="team" disabled value="${m.createDate}">
			            </li>
                        <li style="justify-content: right;">
                            <button type="submit" class="update">수정하기</button>
                        </li>
			        </ul>
			    </form>
			</div>
	
	        <!-- Footer -->
	        <div class="footer">
	            <p>DevHelper team number 3 let's go</p>
	        </div>
	    </div>
	</div>
    <!-- Bootstrap Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>
</body>
</html>