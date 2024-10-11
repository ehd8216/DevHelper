<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
			<link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet" />
			<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
			<script defer src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.23.0/themes/prism.min.css" />
			<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.23.0/prism.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.23.0/prism-java.min.js"></script>
			<!-- <script defer src="resources/js/newsApi.js"></script> 이거 나중에 spring으로 -->
			<link rel="stylesheet"
				href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"
				integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g=="
				crossorigin="anonymous" referrerpolicy="no-referrer" />
			<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"
				integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw=="
				crossorigin="anonymous" referrerpolicy="no-referrer"></script>
			<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
			<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
			<style>
				@font-face {
					font-family: 'GangwonEdu_OTFBoldA';
					src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
					font-weight: normal;
					font-style: normal;
				}

				html {
					overflow-y: scroll;
					/* Forces vertical scrollbar */
				}

				body * {
					font-family: 'GangwonEdu_OTFBoldA';
					font-weight: normal;
				}

				header {
					display: flex;
					width: 98vw;
					height: 70px;
					background-color: antiquewhite;
					align-items: center;
					position: relative;
					top: 15px;
					font-size: 20px;
					margin: auto;
					z-index: 10;
					line-height: 75px;
					border-radius: 10px;
				}

				.project_name {
					margin-left: 2%;
					width: 140px;
					height: 100%;
					cursor: pointer;
				}

				.menubar {
					display: flex;
					position: absolute;
					right: 20%;
					transition: .4s;
					height: 100%;
					width: 50%;
					overflow: hidden;

				}

				.menuEls {
					height: 70px;
					transition: .4s;
					cursor: pointer;
					width: 20%;
					text-align: center;
					z-index: 1;
				}

				.menuEls:hover {
					font-size: 21px;
				}

				.menuSlide {
					height: 64px;
					position: absolute;
					background-color: rgb(250, 208, 93);
					width: 20%;
					transform: translateX(-100%);
					z-index: 0;
					transition: .4s;
					border-radius: 10px;
					margin-top: 3px;
				}

				.outer {
					position: relative;
					width: 98vw;
					height: auto;
					border-radius: 10px;
					margin: 10px auto;
					overflow: hidden;
					padding: 5px;
					display: flex;
					flex-direction: column;
					transition: .3s;
				}

				.outer::before {
					content: "";
					position: absolute;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					background-image: url(resources/image/Designer5.jpeg);
					background-size: cover;
					background-attachment: fixed;
					opacity: 0.2;
					z-index: -1;
				}

				/*로그인 안했을때*/
				.about_user {
					position: absolute;
					display: flex;
					right: 1%;
					height: 100%;
					width: 5%;
					border-radius: 10px;
				}

				.about_user span {
					height: 100%;
					width: 50%;
					font-size: 35px;
					line-height: 200%;
					cursor: pointer;
					transition: .2s;
				}

				/*로그인 했을때*/
				.about_login_user {
					position: absolute;
					display: flex;
					right: 0%;
					height: 100%;
					width: 15%;
					border-radius: 10px;
				}

				.about_login_user span {
					height: 100%;
					font-size: 35px;
					line-height: 200%;
					cursor: pointer;
					transition: .2s;
					box-sizing: border-box;
				}

				.about_login_user .login_user2 {
					font-size: 25px;
					margin-top: 6%;
				}

				.about_login_user .login_user2 a:hover {
					text-decoration: underline;
					cursor: pointer;
				}

				.about_login_user .login_user2 img {
					width: 32px;
					height: 32px;
				}

				/*로그인 후 개인 menu*/
				.dropdown-menu {
					display: none;
					/* 기본적으로 감춤 */
					position: absolute;
					background-color: #f9f9f9;
					box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
					z-index: 1;
					width: 150px;
					top: 100%;
					/* 부모 요소 높이에 대한 100% 아래에서 시작 */
					left: 15%;
					opacity: 0;
					/* 처음에는 투명 */
					max-height: 0;
					/* 처음에는 높이 0 */
					overflow: hidden;
					/* 내용이 넘치지 않도록 */
					transition: opacity 0.2s ease, max-height 0.2s ease;
					/* 트랜지션 속성 추가 */
				}

				.dropdown-menu.show {
					display: block;
					/* 메뉴를 보여줌 */
					opacity: 1;
					/* 투명도를 1로 변경 */
					max-height: 500px;
					/* 적당한 최대 높이 설정 */
				}

				.dropdown-menu ul {
					list-style-type: none;
					margin: 0;
					padding: 0;
				}

				.dropdown-menu ul li {
					padding: 8px;
					text-align: left;
				}

				.dropdown-menu ul li a {
					text-decoration: none;
					color: black;
					display: block;
				}

				.dropdown-menu ul li a:hover {
					background-color: #f1f1f1;
				}

				.modals {
					width: 400px;
					height: 300px;
					right: 10%;
					top: 20%;
					display: flex;
					position: absolute;
					z-index: 10;
				}

				.modals.show {
					display: none;
				}
			</style>
		</head>

		<body>


			<header>
				<img class="project_name" src="resources/image/logo-removebg-preview.png" onclick="toThe('toMain')" />

				<div class="menubar">
					<div class="menuSlide"></div>
					<div class="menuEls" onclick="toThe('searchNews')">HOME</div>
					<div class="menuEls" onclick="toThe('myRepo.re')">My Repository</div>
					<div class="menuEls">코딩테스트</div>
					<div class="menuEls" onclick="toThe('list.wo')">취업관련</div>
					<c:if test="${not empty loginMember}">
						<div class="menuEls" onclick="toThe('list.bo?memNo=${loginMember.memNo}')">게시판</div>
					</c:if>
				</div>`
				<c:choose>
					<c:when test="${not empty loginMember}">
						<div class="about_login_user">
							<span class="material-icons login_user1" onclick="toCodeTyping()"
								style="width: 20%">description</span>
							<span class="login_user2" style="width: 80%"><img
									src="${loginMember.profile}">${loginMember.gitNick} <a style="font-size: 15px"
									onclick="toggleMenu()">▼</a></span>
							<div id="dropdownMenu" class="dropdown-menu">
								<ul>
									<li><a href="mypage.me?memNo=${loginMember.memNo}">MyPage</a></li>
									<li><a class="modal_btn" style="cursor: pointer;">MakeForum</a></li>
									<li><a href="logout.me">Logout</a></li>
								</ul>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="about_user">
							<span class="material-icons" onclick="toCodeTyping()">description</span>
							<span class="material-symbols-outlined" onclick="toThe('login.me')">login</span>
						</div>
					</c:otherwise>
				</c:choose>
			</header>

			<div class="modals show">

				<div class="modal_body">

					<h2>title</h2>
					<p>
					<form id="createRoomForm">
						<input type="text" id="roomName" placeholder="Room Name" required />
						<input type="password" id="roomPassword" placeholder="Password" required />
						<button type="button" onclick="createRoom()">Create Room</button>
					</form>
					</p>
					<span class="close_modal">x</span>

				</div>

			</div>

			<script>
				$(document).ready(() => {

					$(".modal_btn").on("click", () => {
						$(".modals").toggleClass("show")
					});

					$(".close_modal").on("click", () => {
						$(".modals").toggleClass("show")
					});

				});

				function createRoom() {
					const roomName = $('#roomName').val();
					const roomPassword = $('#roomPassword').val();

					$.ajax({
						url: "createRoom",
						data: {
							name: roomName,
							password: roomPassword,
						},
						success: (result) => {

							if (result == 0) {
								toastr.warning("${warningMsg1}")
							} else if (result == 1) {
								toastr.success("${alertMsg1}"
									+ "콘솔창을 확인하세요"
								)
								console.log("${alertMsg1}")
							} else {
								toastr.error("${errorMsg1}")
							}

						},
					})

				}
			</script>

			<div class="outer">

			</div>

			<script>
				toastr.options = {
					"progressBar": true,
					"timeOut": "1800",
				}
				const menuEls = document.querySelectorAll('.menuEls');
				const menuSlide = document.querySelector('.menuSlide');
				let currentIndex = 0;

				menuEls.forEach((el, index) => {
					el.addEventListener('mouseover', () => {
						menuSlide.style.transform = `translateX(\${index * 100}%)`;
						currentIndex = index;
					});
				});

				document.querySelector('.menubar').addEventListener('mouseleave', () => {
					menuSlide.style.transform = `translate(\${currentIndex * 100}%, 105%)`;
				});

				function toThe(url) {
					location.href = url;
				}

				function toCodeTyping() {
					const newWindow = window.open("openMonaco", '_blank', 'width=800,height=1000');
				}

				const icons = document.querySelectorAll('.about_user span');

				icons.forEach(icon => {

					icon.addEventListener('mouseenter', () => {
						icon.style.color = 'rgb(250, 208, 93)';
					});

					icon.addEventListener('mouseleave', () => {
						icon.style.color = '';
					});

				});
				function toggleMenu() {
					var menu = document.getElementById("dropdownMenu");
					if (menu.classList.contains("show")) {
						menu.classList.remove("show");
					} else {
						menu.classList.add("show");
					}
				}
			</script>

			<c:if test="${ not empty alertMsg }">
				<script>
					toastr.success("${alertMsg}");
				</script>
				<c:remove var="alertMsg" />
			</c:if>

			<c:if test="${ not empty errorMsg }">
				<script>
					toastr.error("${errorMsg}");
				</script>
				<c:remove var="errorMsg" />
			</c:if>

		</body>

		</html>