<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>Insert title here</title>
				<style>
					.outer {
						width: 100vw;
						height: 100vh;
						display: flex;
						flex-direction: column;
					}

					#sortingBar {
						height: 60px;
						display: flex;
						align-items: center;
						position: relative;

						& button {
							border-radius: 5px;
							font-size: 18px;
							background-color: white;
							height: 35px;
							line-height: 35px;
							margin-left: 3%;
							cursor: pointer;
						}

						& #languages {
							display: flex;
							font-size: 12px;
							position: absolute;
							right: 15%;
							flex-direction: column;
							color: gray;
							height: 100%;
							justify-content: center;
						}

						& #language {
							height: 25px;
							background-color: white;
							font-size: 16px;
							border-radius: 5px;
							line-height: 20px;
						}

						& #radios {
							height: 100%;
							position: absolute;
							right: 5%;
							display: flex;
							flex-direction: column;
							color: gray;
							font-size: 12px;
							justify-content: center;

							& #answers {
								font-size: 16px;
								color: black;
							}
						}
					}

					#boardList {
						width: 100%;
						height: 756px;
						display: flex;
						flex-wrap: wrap;
						gap: 1%;

						& .boards {
							width: 32.5%;
							height: 46%;
							border: 1px solid #000;
							position: relative;
							border-radius: 10px;


							& .answerMark {
								position: absolute;
								width: 30px;
								height: 30px;
								background-color: rgb(241, 239, 107);
								right: 5px;
								top: -31px;
								display: flex;
								justify-content: center;
								line-height: 33px;
							}

							& .thumbnail {
								width: 100%;
								height: 94%;
								display: flex;
								align-items: center;
								justify-content: center;
								position: relative;
								overflow: hidden;
								border-top-left-radius: 10px;
								border-top-right-radius: 10px;

								& pre {
									width: 100%;
									height: 100%;
									padding: 0;
									margin: 0;
								}

								& .language-js {
									width: 100%;
									height: 100%;
									display: block;
									overflow: auto;
									position: absolute;
								}
							}

							& .underBoard {
								width: 100%;
								height: 6%;
								display: flex;
								align-items: center;
								position: relative;
								justify-content: space-between;
								background-color: #fff;
								border-bottom-left-radius: 10px;
								border-bottom-right-radius: 10px;

								& .underBoardInfo {
									display: flex;
									align-items: center;
									gap: 3%;
									height: 100%;
									width: 30%;
									justify-content: end;
								}
							}
						}
					}

					#pagingArea {
						width: 100%;
						height: 6%;

						& .pagination {
							display: flex;
							gap: 1%;
							justify-content: center;
						}
					}
				</style>
			</head>

			<body>
				<!-- <code class="language-js">const hello = 'Hello, world!';</code> 이거 스니펫.. -->
				<jsp:include page="../common/menubar.jsp" />

				<div class="outer">

					<div id="sortingBar">
						<button onclick="toEnroll();">게시글 작성</button>

						<div id="languages"> 사용언어
							<select id="language">
								<option value="">JavaScript</option>
								<option value="">HTML</option>
								<option value="">JAVA</option>
							</select>
						</div>

						<div id="radios"> 답변여부
							<div id="answers">
								<label>
									<input type="radio" name="answered" value="a"> 답변됨
								</label>
								<label>
									<input type="radio" name="answered" value="n"> 답변안됨
								</label>
							</div>
						</div>

					</div>

					<div id="boardList">

						<c:forEach var="b" items="${list}">

							<div class="boards">
								<c:if test="${b.answer eq 'Y'}">
									<div class="answerMark">🏆</div>
								</c:if>
								<div class="thumbnail">
									<pre>
<code class="language-js" id="code-${b.boardNo}">${b.code}</code>
									</pre>
								</div>
								<div class="underBoard">
									<div class=lang>${b.boardLang}</div>
									<div class="title">${b.boardTitle}</div>
									<div class="underBoardInfo">
										<div class="count">${b.boardCount}</div>
										<div class="date">${b.createDate}</div>
									</div>
								</div>
							</div>



						</c:forEach>

					</div>


					<div id="pagingArea">
						<ul class="pagination">

							<c:choose>
								<c:when test="${ pi.currentPage eq 1 }">
									<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
								</c:when>

								<c:otherwise>
									<li class="page-item"><a class="page-link"
											href="list.bo?cPage=${ pi.currentPage - 1 }&memNo=${loginMember.memNo}">Previous</a>
									</li>
								</c:otherwise>
							</c:choose>

							<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
								<li class="page-item"><a class="page-link"
										href="list.bo?cPage=${ p }&memNo=${loginMember.memNo}">${ p }</a></li>
							</c:forEach>

							<c:choose>
								<c:when test="${ pi.currentPage eq pi.endPage }">
									<li class="page-item disabled"><a class="page-link" href="">Next</a></li>
								</c:when>

								<c:otherwise>
									<li class="page-item"><a class="page-link"
											href="list.bo?cPage=${ pi.currentPage + 1 }&memNo=${loginMember.memNo}">Next</a>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>

				</div>

				<script>
					function toEnroll() {
						location.href = "enrollForm.bo";
					}

				</script>

			</body>

			</html>