<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head>
    <meta charset="UTF-8">
    <title>자기소개서 도우미</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f7f8fa;
            color: #333;
        }
        .coverletter {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }
        h2 {
            font-size: 18px;
            color: #555;
            margin-bottom: 20px;
        }
        .form-container {
            text-align: left;
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            resize: vertical;
            height: 100px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table .static {
            font-weight: bold;
            padding-bottom: 5px;
        }
        table .answer input,
        table .answer textarea {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        table .answer {
            padding-bottom: 10px;
        }
        button {
            background-color: antiquewhite;
            color:black;
            border: none;
            padding: 15px 20px;
            cursor: pointer;
            border-radius: 8px;
            font-size: 16px;
            margin-top: 20px;
            display: block;
            width: 100%;
        }
        button:hover {
            background-color:rgba(250, 235, 215, 0.89);
        }
        .example-toggle {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        input,
        textarea{
            font-size: 18px;
        }
    </style>
    </head>
    <body>
    <jsp:include page="../common/menubar.jsp" />

    <div class="coverletter">
        <h1 style="font-size: 40px; padding-top: 30px;">자기소개서 도우미</h1>
        <h2 style="font-size: 20px; padding: 15px 0 15px 0;">질문에 답변하고 openAI와 함께 자기소개서를 작성해보세요!</h2>

        <div class="example-toggle">
            <input type="checkbox" id="exampleToggle">
            <label for="exampleToggle">예시로 채우기</label>
        </div>

        <div class="form-container" style="font-size: 20px;">
            <table>
                <tr class="static">
                    <td>지원 기업</td>
                    <td>지원 직무</td>
                    <td>글자 수</td>
                </tr>
                <tr class="answer">
                    <td><input type="text" id="companyName" placeholder="기업명을 입력하세요"></td>
                    <td><input type="text" id="jobTitle" placeholder="지원 직무"></td>
                    <td><input type="number" id="maxLength" step="100" max="1000" min="500" placeholder="500"></td>
                </tr>
                <tr class="static">
                    <td colspan="3">질문</td>
                </tr>
                <tr class="answer">
                    <td colspan="3"><textarea id="question" placeholder="질문을 입력하세요"></textarea></td>
                </tr>
                <tr class="static">
                    <td colspan="3">질문에 대한 나의 경험</td>
                </tr>
                <tr class="answer">
                    <td colspan="3"><textarea id="experience" placeholder="경험을 입력하세요"></textarea></td>
                </tr>
                <tr>
                    <td colspan="3"><button>AI를 통해 작성</button></td>
                </tr>
            </table>
        </div>
    </div>

    <script>
        const exampleData = {
            companyName: "kakao",
            jobTitle: "웹 개발자",
            maxLength: 500,
            question: "팀원들과 함께 하나의 프로젝트를 진행하면서 힘들었던점은 무엇이고 어떻게 극복했나요?",
            experience: "서버세팅을 함께 세팅하는 것과 중간에 프로젝트를 그만두는 팀원들 때문에 힘들었다."
        };

 
        function fillExampleData() {
            $("#companyName").val(exampleData.companyName);
            $("#jobTitle").val(exampleData.jobTitle);
            $("#maxLength").val(exampleData.maxLength);
            $("#question").val(exampleData.question);
            $("#experience").val(exampleData.experience);
        }

        function clearForm() {
            $("#companyName").val('');
            $("#jobTitle").val('');
            $("#maxLength").val('');
            $("#question").val('');
            $("#experience").val('');
        }

        // Toggle filling in the example data
        $('#exampleToggle').on('change', function () {
            if (this.checked) {
                fillExampleData();
            } else {
                clearForm();
            }
        });
    </script>
    </body>
    </html>