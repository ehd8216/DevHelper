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
					height: 85vh;
					display: flex;
					margin: auto;

					& .enroll-left {
						width: 50%;
						height: 90%;

						& .codeInput {
							width: 95%;
							height: 90%;
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
					padding: 20px;
				}

				.form-table {
					width: 100%;
					border-collapse: collapse;
				}

				.form-row {
					display: flex;
					align-items: center;
					width: 100%;
					margin-bottom: 10px;
				}

				.form-input,
				.form-textarea {
					width: 100%;
					box-sizing: border-box;
					padding: 10px;
					border-radius: 4px;
					border: 1px solid #ccc;
					font-size: 16px;
					margin-left: 10px;
				}

				.form-textarea {
					resize: none;
					height: 400px;
				}

				.form-button-cell {
					text-align: right;
				}

				.submit-button {
					width: 100%;
					padding: 10px;
					font-size: 16px;
					border-radius: 4px;
					cursor: pointer;
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

					<table class="form-table">
						<tr class="form-row">
							<td>제목 :</td>
							<td><input type="text" class="form-input"></td>
						</tr>
						<tr class="form-row">
							<div id="languages"> 사용언어
								<select id="language">
									<option>JavaScript</option>
									<option>HTML</option>
									<option>JAVA</option>
								</select>
							</div>
						</tr>
						<tr class="form-row">
							<td>내용 :</td>
							<td><textarea class="form-textarea"></textarea></td>
						</tr>
						<tr>
							<td class="form-button-cell" colspan="2">
								<button type="submit" class="submit-button">Submit Code</button>
							</td>
						</tr>
					</table>

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