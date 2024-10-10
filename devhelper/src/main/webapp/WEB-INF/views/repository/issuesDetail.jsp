<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issue Detail</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        padding: 20px;
    }

    .content {
        max-width: 900px;
        margin: 0 auto;
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #343a40;
    }

    table {
        width: 100%;
        margin-bottom: 20px;
    }

    th {
        background-color: #343a40;
        color: rgb(0, 0, 0);
        text-align: left;
        padding: 10px;
    }

    td {
        padding: 10px;
        border: 1px solid #dee2e6;
        text-align: left;
    }

    p {
        margin: 0;
    }

    .innerOuter {
        padding: 20px;
    }
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp" />
    <div class="content">
        <h2>Issue Detail</h2>
        <div class="innerOuter">
            <table id="contentArea" class="table table-bordered">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${issueDe.getTitle()}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${issueDe.getUser().getLogin()}</td>
                    <th>작성일</th>
                    <td>${issueDe.getCreatedAt()}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p style="height:150px; overflow-y: auto;">${issueDe.getBody()}</p>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
