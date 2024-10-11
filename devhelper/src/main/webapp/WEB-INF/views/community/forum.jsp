<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.12/ace.js"></script>
			<script>
				window.onload = function () {
					var password = prompt("비밀번호 : ");

					if (password) {
						validatePassword(password);
					} else {
						alert("비밀번호를 제대로 입력하세요");
						window.location.href = "previousPage.html";
					}
				};

				function validatePassword(password) {

					var roomId = "${ roomId }";

					$.ajax({
						url: "validate.fo",
						data: {
							roomId: roomId,
							roomPwd: password,
						},
						success: result => {

							if (result == 0) {
								document.getElementById('content').style.display = 'block';
								toastr.success('"${roomName}"' + "방 입장")
							} else {
								window.location.href = "previousPage.html";
							}

						}
					})

				}
			</script>
			<style>
				#editor {
					width: 60%;
					height: 81.8vh;
					border-radius: 5px;
				}

				@keyframes blink {

					0%,
					100% {
						opacity: 0.5;
					}

					50% {
						opacity: 1;
						font-weight: bolder;
					}
				}

				.dot {
					font-size: 34px;
					animation: blink 1.4s linear infinite;
				}

				.dot:nth-child(1) {
					animation-delay: 0.4s;
				}

				.dot:nth-child(2) {
					animation-delay: 0.2s;
				}

				.dot:nth-child(3) {
					animation-delay: 0s;
				}

				.dot:nth-child(4) {
					animation-delay: 0s;
				}

				.dot:nth-child(5) {
					animation-delay: 0.2s;
				}

				.dot:nth-child(6) {
					animation-delay: 0.4s;
				}

				.roomTitle {
					text-align: center;
					margin-bottom: 10px;
				}

				.forum {
					display: flex;
					gap: 1%;

					& .chat {
						width: 39%;
						height: 81.8vh;
						border-radius: 5px;
						background-color: rgb(182, 228, 247);
						position: relative;
						overflow: auto;
					}
				}

				/* .chat-input {
					display: flex;
					margin-top: 10px;
					position: absolute;
					width: 100%;
					bottom: 0;
				}

				.chat-input input {
					font-size: 16px;
					flex: 1;
					padding: 5px;
					border: 1px solid #ccc;
					border-radius: 5px;
					outline: none;
				}

				.chat-input button {
					padding: 10px;
					margin-left: 5px;
					border: none;
					background-color: #28a745;
					color: white;
					border-radius: 5px;
					cursor: pointer;
				}

				.chat-input button:hover {
					background-color: #218838;
				} */
			</style>
		</head>

		<body id="content" style="display: none;">

			<jsp:include page="../common/menubar.jsp" />

			<div class="outer">

				<div class="roomTitle">
					<div style="color: rgb(145, 123, 1); font-size: 30px;"><span class="dot">·</span>
						<span class="dot">·</span>
						<span class="dot">·</span>
						${roomName} <span class="dot">·</span>
						<span class="dot">·</span>
						<span class="dot">·</span>
					</div>
				</div>

				<div class="forum">

					<div id="editor"></div>

					<div class="chat">


						<!-- <div class="chat-input">
							<input type="text" id="chatInput" placeholder="메시지를 입력하세요..." />
							<button onclick="sendChatMessage()">전송</button>
						</div> -->
						<div id="disqus_thread"></div>
						<script>
							/**
							*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
							*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables    */

							var disqus_config = function () {

								this.page.url = window.location.href;
								this.page.identifier = '${b.boardNo}';

								console.log('Disqus config initialized for page:', this.page.url);

								// 여기 어떻게 상호작용 끌어와서 저 답변됨 체크할수있도록 수정할것
								this.callbacks.onCommentPinned = [function (comment) {
									// Your custom code when a comment is pinned
									console.log('Comment pinned:', comment);
								}];

								this.callbacks.onNewComment = [function (comment) {
									console.log('New comment added:', comment);
								}];

							};

							(function () { // DON'T EDIT BELOW THIS LINE
								var d = document, s = d.createElement('script');
								s.src = 'https://devhelper-2.disqus.com/embed.js';
								s.setAttribute('data-timestamp', +new Date());
								(d.head || d.body).appendChild(s);
							})();
						</script>
						<noscript>Please enable JavaScript to view the <a
								href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>

					</div>

				</div>

				<script>
					// Ace Editor 초기화
					const editor = ace.edit("editor");

					editor.setTheme("ace/theme/iplastic");
					editor.session.setMode("ace/mode/${language}");
					editor.setFontSize(16);
				</script>

				<script>
					const socket = new WebSocket('ws://localhost:8234/dh/collab'); // yourContextPath는 실제 경로로 변경

					socket.onopen = function () {
						console.log("WebSocket 연결됨");
					};

					socket.onmessage = function (event) {
						const data = JSON.parse(event.data);
						if (data.type === 'codeUpdate') {
							editor.setValue(data.code); // 코드 에디터에 업데이트
						}
					};

					function sendCodeUpdate(code) {
						socket.send(JSON.stringify({ type: 'codeUpdate', code }));
					}

					// 코드 에디터에서 변화가 생겼을 때 호출
					editor.on('change', () => {
						const code = editor.getValue();
						sendCodeUpdate(code);
					});
				</script>

			</div>

		</body>

		</html>