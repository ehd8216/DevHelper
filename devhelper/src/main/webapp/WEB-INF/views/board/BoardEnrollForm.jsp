<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<style>
				.enrollForm {
					width: 98%;
					height: 88vh;
					display: flex;
					margin: auto;
					transition: .4s;

					& .enroll-left {
						width: 50%;
						height: 100%;

						& .codeInput {
							width: 95%;
							height: 98%;
							resize: none;
							margin: auto;
							border-radius: 6px;
							font-size: 22px;
						}
					}

					&::before {
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

				}

				.enroll-right {
					width: 50%;
					height: 100%;
					display: flex;
					flex-direction: column;
					gap: 20px;
					font-size: 20px;
				}

				.er1 {
					display: flex;
					height: 5%;
					width: 100%;
					align-items: center;
					gap: 10px;

					& .er1_input {
						width: 80%;
						height: 100%;
					}

					& .form-input {
						display: flex;
						width: 100%;
						height: 60%;
						box-sizing: border-box;
						font-size: 20px;
						margin: auto 5%;
						padding: 2%;
					}
				}

				.er2 {
					display: flex;
					gap: 1%;
					justify-content: flex-end;
					margin-right: 10.5%;
					align-items: center;
				}

				#language {
					height: 100%;
				}

				.er3 {
					display: flex;
					gap: 10px;

					& .er3_input {
						width: 80%;

						& textarea {
							display: flex;
							width: 100%;
							box-sizing: border-box;
							font-size: 20px;
							margin: auto 5%;
							padding: 2%;
						}
					}
				}

				.er4 {
					width: 39.6%;
					display: flex;
					margin: auto;
					position: absolute;
					bottom: 2.6%;
					right: 5.6%;

					& .submit-button {
						width: 100%;
						height: 40px;
						box-sizing: border-box;
						margin-right: 4px;
						cursor: pointer;
						font-size: 15px;
						background-color: antiquewhite;
						border-radius: 5px;
						opacity: .8;
						transition: .4s;

						&:hover {
							opacity: 1;
						}
					}
				}
			</style>
		</head>

		<body>

			<jsp:include page="../common/menubar.jsp" />
			<div class="enrollForm">
				<div class="enroll-left">
					<textarea class="codeInput" rows="33" placeholder="코드를 입력해보세요"></textarea>
				</div>
				<div class="enroll-right">

					<div class="er1">
						<div>제목 :</div>
						<div class="er1_input"><input type="text" class="form-input" maxlength="50"
								placeholder="제목을 입력하세요 (최대 50자)"></div>
					</div>

					<div class="er2" id="languages">
						사용언어 :
						<select id="language">
							<option>JavaScript</option>
							<option>HTML</option>
							<option>JAVA</option>
						</select>
					</div>

					<div class="er3">
						<div>내용 :</div>
						<div class="er3_input"><textarea class="form-textarea" rows="25" style="resize: none;"
								maxlength="500" placeholder="내용을 입력하세요 (최대 500자)"></textarea></div>
					</div>

					<div>
						<div class="er4">
							<button type="submit" class="submit-button">등록하기</button>
						</div>
					</div>

				</div>
			</div>

			<script>

				$(() => {
					$(".submit-button").click(() => {
						const code = $(".codeInput").val();
						// .replace(/&/g, "&amp;")
						// .replace(/"/g, "&quot;")
						// .replace(/'/g, "&#39;");
						const title = $(".form-input").val();
						const content = $(".form-textarea").val();
						const lang = $("#language").val();
						$.ajax({
							url: "insert.bo",
							data: {
								boardWriter: ${ loginMember.memNo },
							code: code,
							boardTitle: title,
							boardContent: content,
							boardLang: lang,
							},
						success: result => {
							if (result) {
								window.location.href = "list.bo?memNo=${loginMember.memNo}";
							}
						},
						error: () => {
							console.log("게시글 작성용 ajax 실패");
						},
						})
					})
				})

			</script>

		</body>

		</html>