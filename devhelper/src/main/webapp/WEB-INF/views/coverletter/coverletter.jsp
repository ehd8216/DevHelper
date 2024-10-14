<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .write {
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
        .write:hover {
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
    <jsp:include page="../common/backToTop.jsp" />
    <div class="coverletter">
        <h1 style="font-size: 40px; padding-top: 30px;">자기소개서 도우미</h1>
        <h2 style="font-size: 20px; padding: 15px 0 15px 0;">질문에 답변하고 openAI와 함께 자기소개서를 작성해보세요!</h2>

        <div class="example-toggle">
            <input type="checkbox" id="exampleToggle">
            <label for="exampleToggle">예시로 채우기</label>
        </div>
        <div style="font-size: 20px;">나의 스킬
            <input type="text" id="newSkill" style="width: 15%;">
            <button id="addSkillBtn">추가</button>
            <button id="delSkillBtn">삭제</button>
            <div id="skill"></div>
        </div>
    

        <div class="form-container" style="font-size: 20px;">
            <table>
                <tr class="static">
                    <td>지원 기업</td>
                    <td>지원 직무</td>
                    <td>글자 수</td>
                </tr>
                <tr class="answer">
                    <td><input type="text" id="companyName" placeholder="기업명을 입력하세요" required></td>
                    <td><input type="text" id="jobTitle" placeholder="지원 직무를 입력하세요" required></td>
                    <td><input type="number" id="maxLength" step="100" max="700" min="300" placeholder="500" required></td>
                </tr>
                <tr class="static">
                    <td colspan="3">지원동기</td>
                </tr>
                <tr class="answer">
                    <td colspan="3"><textarea id="motivation" placeholder="간단한 지원동기를 입력하세요" required></textarea>
                    </td>
                </tr>
                <tr class="static">
                    <td colspan="3">질문
                        <input type="text" id="question" placeholder="질문을 입력하세요" required>
                    </td>
                </tr>
                <tr class="static">
                    <td colspan="3">질문에 대한 나의 경험</td>
                </tr>
                <tr class="answer">
                    <td colspan="3"><textarea id="experience" placeholder="간단한 경험을 입력하세요" required></textarea>
                    </td>
                </tr>
             
            </table>
            <button class="write" id="generateAI">AI를 통해 작성</button>
            <div class="resultAPI"></div>
        </div>
    </div>

    <script>
    
        $('#generateAI').on('click', function (e) {
            e.preventDefault();
            
            let prompt = [];

            // Push the variables into the array
            prompt.push($("#companyName").val());
            prompt.push($("#jobTitle").val());
            prompt.push($("#maxLength").val());
            prompt.push($("#motivation").val());
            prompt.push($("#question").val());
            prompt.push($("#experience").val());

            $.ajax({
                url:"chat",
                type:"GET",
                data:{prompt:prompt},
                success:function(response){

                },
                error:function(){
                    console.log("chat API 에러");
                }
            })
            
            
       
    });

        const exampleData = {
            companyName: "kakao",
            jobTitle: "웹 개발자",
            maxLength: 500,
            motivation:"이곳에 지원한 이유는 제가 개발자로서 추구하는 방향과 가장 적합하다고 생각했기때문입니다.",
            question: "웹 개발자로서 나의 강점은 무엇인가요?",
            experience: "개발자로서 하나의 완성된 프로젝트를 만들기 위해 팀원들과 의견을 조율하고 소통하는 능력이 제 장점이라고 생각합니다.",
        };

 
        function fillExampleData() {
            $("#companyName").val(exampleData.companyName);
            $("#jobTitle").val(exampleData.jobTitle);
            $("#maxLength").val(exampleData.maxLength);
            $("#motivation").val(exampleData.motivation);
            $("#question").val(exampleData.question);
            $("#experience").val(exampleData.experience);
        }

        function clearForm() {
            $("#companyName").val('');
            $("#jobTitle").val('');
            $("#maxLength").val('');
            $("#motivation").val('');
            $("#question").val('');
            $("#experience").val('');
        }

        $('#exampleToggle').on('change', function () {
            if (this.checked) {
                fillExampleData();
            } else {
                clearForm();
            }
        });

        // 스킬 추가 삭제 버튼
        let skillsArray = [];

        function updateSkillsDisplay() {
            $('#skill').text(skillsArray.join(', '));
        }

        $('#addSkillBtn').on('click', function () {
        const newSkill = $('#newSkill').val().trim();
        if (newSkill) {
            // 새로운 스킬을 배열에 추가
            skillsArray.push(newSkill);
            updateSkillsDisplay(); // 화면에 스킬 업데이트
            $('#newSkill').val(''); // 입력창 초기화
        }
        });

        $('#delSkillBtn').on('click',function(){
            if(skillsArray.length>0){
                skillsArray.pop();
                updateSkillsDisplay();
            }
        })


    </script>
    </body>
    </html>