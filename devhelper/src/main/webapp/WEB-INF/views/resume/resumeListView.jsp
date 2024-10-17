<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .wrap {
            width: 70%;
            margin: 0 auto;
            padding: 20px;
        }

        #top-word{
            font-size: 40px;
            color: #333;
            margin-bottom: 20px;
			padding: 50px 0 50px 0;
        }

        .resume {
            background-color:rgb(250, 246, 240);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .resume table {
            width: 100%;
            border-collapse: collapse;
        }

        .resume table td {
            padding: 10px 0;
            color: #333;
            font-size: 16px;
        }

        .resume-title {
            font-size: 18px;
            font-weight: bold;
            color: #007bff;
        }

        .resume .details {
            font-size: 14px;
            color: #6c757d;
            margin-top: 10px;
        }

        .btn-group {
            display: flex;
			justify-content: flex-end; /* Align buttons to the right */
            gap: 20px;
        }

        button {
			background-color: lightgray;
            border: none;
            padding: 10px 15px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
			background-color: #6c757d;
        }

        .secondary-btn:hover {
            background-color: #5a6268;
        }

        .new-resume-btn {
            display: block;
            margin-top: 20px;
            padding: 10px;
            text-align: center;
        }


        .resume-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .resume-header span {
            font-size: 14px;
            color: #6c757d;
        }

        .resume-status {
            color: #28a745;
            font-weight: bold;
            font-size: 14px;
        }

        .highlight {
            color: #ff6f61;
            font-weight: bold;
        }
    </style>

    <meta charset="UTF-8">
    <title>이력서 작성</title>
</head>

<body>
    <jsp:include page="../common/menubar.jsp" />
	<jsp:include page="../common/backToTop.jsp" />
    <div class="wrap">
        <h1 id="top-word">이력서 관리</h1>

        <div class="resume">
            <div class="resume-header">
                <span class="resume-status">내 이력서</span>
                <span>2024-10-17 수정</span>
            </div>
            <table>
                <tr>
                    <td colspan="3" class="resume-title">성실하게 업무를 처리하겠습니다</td>
                </tr>
                <tr>
					<td>희망 지역: 서울 강남구, 강동구, 송파구</td>
                    <td>희망 직무: IT 개발·데이터</td>
                    <td>희망 연봉: 3,000 ~ 3,200 만원</td>
                </tr>
            </table>
            <div class="btn-group">
                <button>수정하기</button>
                <button>삭제하기</button>
            </div>
        </div>

        <button class="new-resume-btn" style="width: 100%;">새로운 이력서 작성하기</button>
		<br>
		<br>
		<hr>
    </div>



</body>

</html>
