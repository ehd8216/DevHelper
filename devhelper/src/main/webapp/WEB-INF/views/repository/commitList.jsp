<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% int num = 1; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
  html::-webkit-scrollbar{
    width: 10px;
  }
  html::-webkit-scrollbar-track { 
    background-color: transparent;
    border-radius: 5px;
  }
  html::-webkit-scrollbar-thumb { 
    background-color: skyblue;
    border-radius: 5px;
  }
  html::-webkit-scrollbar-button{
    display: none;
  }
  @font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
  }
  body * {
    font-family: 'GangwonEdu_OTFBoldA';
    font-weight: normal;
  }
  .outer {
      position: relative;
      height: auto;
      margin: 10px;
      transition: .3s;
      background-color: transparent;
  }
  .commitList{
    min-height: 500px;
    width: 100%;
    backdrop-filter: blur(5px);
  }
  thead tr{
    font-size: 20px;
  }
  tbody tr td{
    cursor: pointer;
    text-align: center;
    font-size: 14px;
    border-top: 1px solid #e5e5e5;

  }
  #commitContent{
    width: 100%;
  }
  #cListTable{
    width: 100%;
  }
  #commitTitle{
    height: 30px;
    text-align: center;
    font-size: 24px;
    font-weight: 700;
  }
</style>
</head>
<body>
	<div class="outer">
    <div class="commitList">

      <div id="commitTitle">
        ${ repoName } Commits
      </div>

      <table id="cListTable">
        <thead>
          <tr style="height: 50px;">
          	<th style="width: 30px;">NO</th>
            <th style="width: 80px;">확정자</th>
            <th style="width: 80px;">메시지</th>
            <th style="width: 80px;">일자</th>
            <th style="width: 80px;">SHA</th>
          </tr>
        </thead>
        <tbody>
        
          <c:forEach var="c" items="${ commitList }">
            <tr id="lTr" style="height: 40px;">
              <td><%= num++ %></td>
              <td>${ c.comAuthor }</td>
              <td>${ c.comMessage }</td>
              <td>${ c.comDate }</td>
              <td id="sha">${ c.SHA }</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <script>
        $(function(){
          $("tbody tr").click(function(){
          	window.open("https://github.com/${url}/commit/" + $(this).children("#sha").text() ,"_blank");
          })
        })

      </script>
      
    </div>
  </div>
</body>
</html>