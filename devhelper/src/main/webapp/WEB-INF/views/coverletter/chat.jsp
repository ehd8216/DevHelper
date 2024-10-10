<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat with GPT</title>
</head>
<body>
    <h1>ChatGPT와 대화해보세요</h1>
    <form id="chatForm" method="post" action="/chat/ask">
        <label for="prompt">질문:</label>
        <input type="text" id="prompt" name="prompt" required>
        <button type="submit">보내기</button>
    </form>

    <div id="responseArea">
        <h2>응답:</h2>
        <p id="chatResponse"></p>
    </div>

    <script>
        document.getElementById("chatForm").addEventListener("submit", function(event) {
            event.preventDefault();  // Prevent default form submission

            const prompt = document.getElementById("prompt").value;

            fetch("/chat/ask", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams({ prompt: prompt })
            })
            .then(response => response.text())
            .then(data => {
                document.getElementById("chatResponse").textContent = data;
            })
            .catch(error => {
                console.error("Error:", error);
            });
        });
    </script>
</body>
</html>