<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<style>
				.detail {
					display: flex;
					justify-content: space-around;
				}

				.dt_left {
					width: 48vw;
					height: 86.6vh;

					& pre {
						padding: 1%;
						width: 95%;
						height: 100%;
						border-radius: 10px;
						position: relative;

						&::-webkit-scrollbar {
							display: none;
						}

						& {
							-ms-overflow-style: none;
							scrollbar-width: none;
						}

						& .language-js {
							position: absolute;
							width: 100%;
							height: auto;
							display: block;
						}
					}
				}

				.dt_right {
					width: 48vw;
					height: 86.6vh;
					display: flex;
					flex-direction: column;

					& .dt_ask {
						width: 100%;
						height: auto;
						border-bottom: 2px solid #838080;
						display: flex;
						flex-direction: column;

						& .dt_ask_top {
							display: flex;
							width: 100%;
							height: auto;

							& .dt_ask_left {
								height: 100%;
								width: 10%;

								& img {
									width: 100%;
									height: auto;
									border-radius: 50%;
									background-color: transparent;
								}

							}

							& .dt_ask_right {
								display: flex;
								flex-direction: column;
								margin-left: 2%;
								justify-content: space-around;
								width: 90%;
								height: 90%;
								margin-top: 1%;

								& .dt_ask_right_title {
									font-size: 25px;
									display: flex;
									justify-content: space-between;
								}

								& .dt_ask_right_infos {
									display: flex;
									justify-content: space-between;
								}
							}

						}

						& .dt_ask_bot {
							width: 100%;
							margin-top: 4%;
							margin-bottom: 15px;
							flex-grow: 1;
							overflow: auto;
						}

					}

					& .dt_reply {
						width: 100%;
						height: auto;
						overflow: auto;
					}
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
					animation: blink 1.5s linear infinite;
				}

				.dot:nth-child(1) {
					animation-delay: 0s;
				}

				.dot:nth-child(2) {
					animation-delay: 0.3s;
				}

				.dot:nth-child(3) {
					animation-delay: 0.6s;
				}
			</style>
		</head>

		<body>

			<jsp:include page="../common/menubar.jsp" />

			<div class="outer">

				<div class="detail">

					<div class="dt_left">
						<pre>
<code class="language-js"><c:forEach var="l" items="${list}"><c:out value="${l.chunkContent}" escapeXml="true" /></c:forEach></code>
</pre>
					</div>

					<div class="dt_right">

						<div class="dt_ask">
							<div class="dt_ask_top">
								<div class="dt_ask_left">
									<img src="${b.profile}">
								</div>
								<div class="dt_ask_right">
									<div class="dt_ask_right_title">
										<div>
											📌${empty b.boardTitle ? "제목 없음" : b.boardTitle}
										</div>
										<c:if test="${loginMember.memNo eq b.boardWriter}"><button id="deleteBoard"
												style="color: red; background-color: transparent;
										cursor: pointer; border-radius: 5px; border: 1px solid red;">게시글 삭제</button></c:if>
									</div>
									<div class="dt_ask_right_infos">
										<div style="color: #DAA520; font-size: 19px;">
											${b.answer eq 'N' ? '구조중<span class="dot">.</span>
											<span class="dot">.</span>
											<span class="dot">.</span>' : '<span class="dot"
												style="font-size: 20px;">✔️구조 완료!</span>'}
										</div>
										<div>
											조회수 : ${b.boardCount} 등록일 : ${b.createDate}
										</div>
									</div>
								</div>
							</div>
							<div class="dt_ask_bot">
								<div class="dt_ask_content">${empty b.boardContent ? "본문 없음" : b.boardContent}</div>
							</div>
						</div>

						<div class="dt_reply">
							<div id="disqus_thread"></div>
							<script>
								/**
								*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
								*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables    */

								var disqus_config = function () {

									this.page.url = window.location.href;
									this.page.identifier = '${b.boardNo}';

									console.log('Disqus config initialized for page:', this.page.url);

									// this.callbacks.onReady = [function () {
									// 	var highlightedPost = $('.highlighted-post');
									// 	if (highlightedPost.length > 0) {
									// 		console.log('Highlighted post found:', highlightedPost);
									// 	} else {
									// 		console.log('No highlighted post found.');
									// 	}
									// }];

									// 여기 어떻게 상호작용 끌어와서 저 답변됨 체크할수있도록 수정할것
									// this.callbacks.onIdentify = [function (comment) {
									// 	// Your custom code when a comment is pinned
									// 	console.log('Comment pinned:', comment);
									// }];

									// this.callbacks.onNewComment = [function (comment) {
									// 	console.log('New comment added:', comment);
									// }];

									// 내 게시글에 댓글달렸을때 문자든, 카톡이든 api를 통한 알림기능
									// 그리고 고정댓글 박으면 답변됨으로 고치게

								};

								(function () { // DON'T EDIT BELOW THIS LINE
									var d = document, s = d.createElement('script');
									s.src = 'https://devhelper-2.disqus.com/embed.js';
									s.setAttribute('data-timestamp', +new Date());
									(d.head || d.body).appendChild(s);
								})();

								$(function () {

									$(document).on("click", "#deleteBoard", function () {

										const bWriter = ${ b.boardWriter };
										const bNo = ${ b.boardNo };

										$.ajax({
											url: "delete.bo",
											data: {
												boardWriter: bWriter,
												boardNo: bNo,
											},
											success: (result) => {
												if (result) {
													location.href = "list.bo?memNo=" + bWriter;
													console.log(result)
												}
											}
										})
									})
								});

								$(document).ready(() => {

									setInterval(() => {
										if ($('.highlighted-post').is(':visible')) {
											console.log("Highlighted post is visible.");
										} else {
											console.log("Highlighted post is not visible.");
										}
									}, 5000);

									function checkDisplayStatus() {
										console.log("Aa")
										console.log($('.highlighted-post').css('display'));
										if ($('.highlighted-post').css('display') == 'block') {
											console.log("고댓 있음");
										} else {
											console.log("고댓 없음");
										}

									}

									setInterval(checkDisplayStatus, 5000);
								})

							</script>
							<noscript>Please enable JavaScript to view the <a
									href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
						</div>
					</div>

				</div>

			</div>

		</body>

		</html>